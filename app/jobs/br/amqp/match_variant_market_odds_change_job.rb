module BR
  module AMQP
    class MatchVariantMarketOddsChangeJob < ApplicationJob
      queue_as :variant_market_odds_change
      include Betradar::MarketOddsUtil
      include Utility::JobUtility::BetStopUtility
      include Utility::JobUtility::PublishDataUtility
      include Utility::JobUtility::OutcomeGenerationUtility

      def perform(variant_markets, variant, match_id)
        @match = Match.find(match_id)
        data = fetch_and_process_data(variant_markets, variant)
        store_player_market_data_in_cache(data)
        store_variant_market_data_in_cache(data)
      end

      private

      def player_market_ids
        @player_market_ids ||= Rails.cache.fetch(:player_market_ids, expire_in: 1.hour) do
          Market.soccer_player_markets.pluck(:id)
        end
      end

      def store_player_market_data_in_cache(data)
        data[:player_markets] = data[:markets].select { |a| player_market_ids.include?(a) }
        old_data = Rails.cache.fetch(::Utility::Cache.odds_change_player_cache_key(@match.id)) || { player_markets: {} }
        new_data = { player_markets: {} }
        new_data[:player_markets] = old_data[:player_markets].deep_merge(data[:player_markets])
        Rails.cache.write(Utility::Cache.odds_change_player_cache_key(@match.id), new_data)
        # data = data.merge(@score) if @score.present?
        publish_data(data, @match, Constants::PLAYER_ODDS_CHANGE_CHANNEL)
      end

      def store_variant_market_data_in_cache(data)
        data[:markets] = data[:markets].reject { |market| player_market_ids.include?(market) }
        old_data = OddStore.new(@match.id).odds_data
        new_data = { markets: {} }
        new_data[:markets] = old_data[:markets].deep_merge(data[:markets])
        OddStore.new(@match.id).odds_data = new_data
        # data = data.merge(@score) if @score.present?
        publish_data(data, @match)
      end

      def filter_markets(markets, variant)
        @markets_data, @all_markets = ::FilterMarkets.call(markets, match: @match, variant: variant)
      end
    end
  end
end
