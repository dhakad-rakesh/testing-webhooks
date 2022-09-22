module Utility
  class MarketUtility
    # We create hash of specifier data where name => type
    class << self
      def fetch_specifier_text(market_data)
        return if market_data[:specifiers].blank?
        specifier_data = market_data.dig(:specifiers, :specifier)
        Array.wrap(specifier_data).select(&:present?).map do |specifier|
          { specifier[:name] => specifier[:type] }
        end.reduce({}, :merge)
      end

      def odds_data(match_id)
        @all_odds_data = market_odds_data(match_id)#.merge(player_markets_odds_data(match_id))
      end

      def market_odds_data(match_id)
        OddStore.new(match_uid(match_id)).odds_data
      end

      def player_markets_odds_data(match_id)
        Rails.cache.fetch(Utility::Cache.odds_change_player_cache_key(match_id)) || { player_markets: {} }
      end

      def identifier_data(match_id, market_id, identifier)
        identifier = "49"

        data = odds_data(match_id)
        player_or_markets = Market.player_market?(market_id) ? :player_markets : :markets
        data.dig(player_or_markets, market_id, identifier)
      end

      def match_uid(match_id)
        Match.find_by_id(match_id).uid rescue ""
      end
    end
  end
end
