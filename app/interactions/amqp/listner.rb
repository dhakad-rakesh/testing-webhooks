# require 'bunny'
# module AMQP
#   # Will make connection to the amqp client and create feed job which will
#   # process data accordingly
#   class Listner < ApplicationInteraction
#     object :session, default: nil, class: Bunny::Session
#     set_callback :validate, :after, -> { set_connection }

#     def execute
#       session.close if session.present?
#       supervise_amqp_access do
#         # Queues
#         prematch_queue = '_2582_'
#         inplay_queue = '_2583_'

#         @retries ||= 0
#         @conn.start
#         ch = @conn.channel

#         ch.basic_qos(1000)

#         GammabetSetting.allow_live_betting

#         ch.basic_consume(inplay_queue, 'consumer', true, false) do |_, _, payload|
#           puts payload
#           perform_feed_job(parsed_payload(payload))
#         end

#         @conn
#       end
#     end

#     private

#     def set_connection
#       STDOUT.sync = true

#       # Hosts
#       prematch_host = 'prematch-rmq.lsports.eu'
#       inplay_host = 'inplay-rmq.lsports.eu'

#       @conn = Bunny.new(
#         host: inplay_host,
#         port: 5672,
#         user: user,
#         password: password,
#         automatic_recovery: true,
#         vhost: 'Customers',
#         continuation_timeout: 1160,
#         allow_self_signed: true
#       )
#     end

#     def user
#       @user ||= Figaro.env.LSPORTS_USER_NAME
#     end

#     def password
#       @password ||= Figaro.env.LSPORTS_PASSWORD
#     end

#     def parsed_payload(payload)
#       JSON.parse(payload).with_indifferent_access
#     end

#     def supervise_amqp_access
#       yield
#     rescue ::StandardError => e
#       GammabetSetting.suspend_live_betting
#       @conn.close
#       retry if (@retries += 1) < 3
#       custom_error_logger(e)
#     end

#     def perform_feed_job(payload)
#       if payload[:Header][:Type] == Constants::LSPORTS_MSG_TYPE["Heartbeat"] # 32
#         Rails.cache.write(:is_ls_heartbeat_on, true, expires_in: 5.seconds)
#       else
#         LS::AMQP::FeedJob.perform_later(
#           '_2583_', payload[:Header][:ServerTimestamp],
#           payload
#         )
#       end
#     end

#     def custom_error_logger(exception)
#       Honeybadger.notify(
#         "[AMQP Listner Error] : [#{exception.class}] : [#{exception.cause}]",
#         class_name: exception.class
#       )
#       AmqpClientErrorMailer.client_error(
#         Figaro.env.developers_mail, exception.class.name, exception.cause,
#         Time.zone.now.to_s
#       ).deliver_later
#     end
#   end
# end
