module LS
  module Prematch
    class MatchMarketsOddsChangeJob < BR::AMQP::MatchMarketOddsChangeJob
      queue_as :prematch_odds_change
      include LS::MarketOddsUtility

      attr_accessor :match_uid

      def perform(data)
        data = data.with_indifferent_access
        @match_uid = data['FixtureId']
        process_and_update_cache(data)
      end
    end
  end
end
