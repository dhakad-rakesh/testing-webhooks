module LS
  module Inplay
    class MatchMarketsOddsChangeJob < BR::AMQP::MatchMarketOddsChangeJob
      queue_as :inplay_odds_change
      include LS::MarketOddsUtility

      attr_accessor :match_uid #, :sport

      def perform(data)
        data = data.with_indifferent_access
        # Use Match service here to return the match & handle all logic there
        # @match = Match.find_by(uid: data['FixtureId'])
        # return if @match.blank?
        @match_uid = data['FixtureId']
        # if OddStoreService.odd_store == :cloud_firestore
        #   publish_to_odd_store(formatted_data(data))
        # else
          # @sport = @match.sport
          process_and_update_cache(data)
        # end
      end

      def publish_to_odd_store(markets)
        return if markets.blank?
        OddStore.new(@match.id).odds_data = { markets: markets }
        @match.update(enabled: true, inplay_subscribed: true) unless @match.enabled? && @match.inplay_subscribed
       end

      def formatted_data(data)
        LS::FormatOddsData.run!(match: @match, data: data)
      end
    end
  end
end
