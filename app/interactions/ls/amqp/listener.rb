require 'bunny'
require 'sidekiq-limit_fetch'
require 'net/http'
module LS
  module AMQP
    # Will make connection to the amqp client and create feed job which will
    # process data accordingly
    class Listener < ApplicationInteraction
      object :session, default: nil, class: Bunny::Session
      boolean :inplay, default: false
      set_callback :validate, :after, -> { set_connection }

      def execute
        return if inplay
        session.close if session.present?
        supervise_amqp_access do          
          @retries ||= 0
          @conn.start
          ch = @conn.channel
          ch.basic_qos(qos)

          GammabetSetting.allow_live_betting
          Rails.logger.info "Start consuming #{key_name}"

          ch.basic_consume(queue, 'consumer', true, false) do |_, _, payload|
            Rails.logger.info payload
            perform_feed_job(parsed_payload(payload))
          end

          @conn
        end
      end

      private

      def set_connection
        STDOUT.sync = true
        
        enable_lsport_package unless inplay
        @conn = Bunny.new(
          host: host,
          port: 5672,
          user: user,
          password: password,
          automatic_recovery: true,
          vhost: 'Customers',
          continuation_timeout: 1160,
          allow_self_signed: true
        )
      end

      def user
        @user ||= Figaro.env.LSPORTS_USER_NAME
      end

      def password
        @password ||= Figaro.env.LSPORTS_PASSWORD
      end

      def inplay_queue
        @inplay_queue ||= ENV.fetch('LSPORTS_INPLAY_QUEUE', '_2751_')
      end

      def prematch_queue
        @prematch_queue ||= ENV.fetch('LSPORTS_PREMATCH_QUEUE', '_2750_')
      end

      def parsed_payload(payload)
        JSON.parse(payload).with_indifferent_access
      end

      def supervise_amqp_access
        yield
      rescue ::StandardError => e
        GammabetSetting.suspend_live_betting
        conn_status = (@conn&.status&.to_sym == :open) ?  :error : @conn&.status
        Rails.cache.write(key_name, conn_status)
        @conn.close
        retry if (@retries += 1) < 3
        custom_error_logger(e)
      end

      # TODO: Rename worker class names
      def perform_feed_job(payload)
        # A lot of refactoring needed
        if payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Heartbeat"]
          Rails.cache.write(key_name, @conn.status, expires_in: 15.seconds)
          Rails.logger.info "#{key_name} connection status: #{@conn.status}"
          # Rails.logger.info payload
        elsif payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Market Update"] # 3 Market update
          payload[:Body][:Events].each do |fixture|
            if inplay
              LS::Inplay::MatchMarketsOddsChangeJob.perform_later(fixture)
            else
              LS::Prematch::MatchMarketsOddsChangeJob.perform_later(fixture)
            end
          end
        elsif payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Fixture metadata"]
          payload[:Body][:Events].each do |fixture|
            LS::Inplay::UpdateMatadataJob.perform_later(fixture)
          end
        elsif payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Settlements"]
          LS::FeedResultJob.perform_later(payload, 'listener_settlement')
        else
          if payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Livescore"] # 2 Livescore update
            payload[:Body][:Events].each do |fixture|
              # if OddStoreService.odd_store == :redis
                single_status_update(fixture)
              # else
              #   push_to_dynamic_queue(fixture)
              # end
            end
          end
          # Below call not needed for prematch
          if inplay
            LS::AMQP::FeedJob.perform_later(
              inplay_queue, payload[:Header][:ServerTimestamp],
              payload
            )
          end
        end
      end

      def custom_error_logger(exception)
        Honeybadger.notify(
          "[AMQP Listner Error] : [#{exception.class}] : [#{exception.cause}]",
          class_name: exception.class
        )
        AmqpClientErrorMailer.client_error(
          Figaro.env.developers_mail, exception.class.name, exception.cause,
          Time.zone.now.to_s
        ).deliver_later
      end

      def queue
        inplay ? inplay_queue : prematch_queue
      end

      def key_name
        inplay ? :amqp_listener_status : :amqp_prematch_listener_status
      end

      def host
        inplay ? inplay_host : prematch_host
      end

      def inplay_host
        'inplay-rmq.lsports.eu'
      end

      def prematch_host
        'prematch-rmq.lsports.eu'
      end

      def push_to_dynamic_queue(fixture)
        queue_name = "odds_#{fixture[:FixtureId]}"
        Sidekiq::Client.push('queue' => queue_name,
          'class' => 'LS::Inplay::MatchStatusUpdateJob',
          'args' => [fixture]
        )
        Sidekiq::Queue[queue_name].limit = 1
      end

      def single_status_update(fixture)
        LS::Inplay::NewMatchStatusUpdateJob.perform_async(fixture[:FixtureId], fixture)
      end

      def qos
        (ENV['LSPORT_QOS'] || 1000).to_i
      end

      def enable_lsport_package
        Net::HTTP.get(URI.parse("#{ENV['LSPORTS_PREMATCH_BASE_URL']}/EnablePackage?username=#{ENV['LSPORTS_USER_NAME']}&password=#{ENV['LSPORTS_PASSWORD']}&guid=#{ENV['LSPORTS_PREMATCH_GUID']}")) rescue nil
      end
    end
  end
end
