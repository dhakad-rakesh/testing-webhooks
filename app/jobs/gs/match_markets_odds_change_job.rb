module GS
  class MatchMarketsOddsChangeJob < ApplicationJob
    queue_as :odds_change

    def perform(json_data = "", retry_count=0)
      # begin
        json_data = fetch_json(json_data)
        json_data.each do |data|
          MatchMarketOddsChangeJob.perform_later(data)
        end
      # rescue GoalServe::Error::RequestReadTimeOut => exception
      #   # Retry job only 5 times
      #   if retry_count > 4
      #     return raise_honeybadger_errors(exception)
      #   end
      #   # Retry job...
      #   return self.class.perform_later(retry_count+1)
      # rescue Exception => exception
      #   return raise_honeybadger_errors(exception)
      # end

      # Will be run after when all odds_change jobs will be finished.
      #MatchDisableJob.perform_later
    end

    private

    def raise_honeybadger_errors(exception)
      Honeybadger.notify(
        "[MatchMarketsOddsChangeJob Error] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def fetch_json(json_data)
      if json_data.present?
        # restrict enqueing if this job already in enqueue
        #GS::FeedResultJob.set(wait_until: Time.zone.now + 10.minutes).perform_later(json_data)
        GoalServe::Format::LiveOdds.new(json_data).call
      else
        #GoalServe::Format::OddsApi.new.call
        GoalServe::Format::PrematchOdds.new.call
      end
    end

    # Will be run after when all odds_change jobs will be finished.
    def disable_matches
      while true
        sleep 3
        if Sidekiq::Queue.new("odds_change").size != 0
          puts 'Odds change queues are running....'
        else
          # Disable matches which don't have odds data.
          matches = Match.active_matches
                         .select{|m| m.odds_data.blank? || m.odds_data[:markets].blank? }

          matches.map(&:disable)
          puts "Disable matches are done............"
          break
        end
      end
    end
  end
end
