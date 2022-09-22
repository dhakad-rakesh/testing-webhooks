module BR
  module AMQP
    class FeedJob < ApplicationJob
      queue_as :amqp_processes

      def perform(routing_key, timestamp, xml)
        # AuditLogJob is respoinsible for logging amqp data, enqueue OddsSummaryJob and enqueue fixture_change
        Rails.cache.write(:last_amqp_data_at, Time.now.utc)
        AuditLogJob.perform_later(routing_key, timestamp, xml)
        args = [xml, routing_key]
        return(MatchMarketOddsChangeJob.perform_later(*args)) if routing_key.include?('odds_change')
        return(BetStopJob.perform_later(*args)) if routing_key.include?('bet_stop')
        return(FeedResultJob.perform_later(xml)) if routing_key.include?('bet_settlement')
      end
    end
  end
end
