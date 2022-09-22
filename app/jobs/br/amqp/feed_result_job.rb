module BR
  module AMQP
    class FeedResultJob < ApplicationJob
      queue_as :result_process
      include Betradar::MarketOddsUtil

      def perform(xml)
        data = xml.xml_to_hash[:bet_settlement]
        return unless data
        @match_uid = data[:event_id]
        markets = data.dig(:outcomes, :market)
        update_markets_status(markets)
        remove_bets_on_hold(markets)
        process_data(Array.wrap(markets))
      end

      private

      def update_markets_status(markets)
        @match = Match.find_by(uid: @match_uid)
        return if @match.blank? || @match.non_supported_tournament?
        # updated_data = modify_markets_status(markets)
        updated_data, player_data = modify_markets_status(markets)
        OddStore.new(@match.id).odds_data = updated_data
        Rails.cache.write(Utility::Cache.odds_change_player_cache_key(@match.id), player_data)
      end

      # TODO: Include module here and make this code common. Done now this way to prevent scope resolution errors
      def modify_markets_status(markets)
        data, player_data = fetch_odds_data
        Array.wrap(markets).each do |market_data|
          market = Market.find_uid(market_data[:id])
          next if market.blank?
          identifier = identifier_value(market_data)
          market_id = market.id
          # Set inactive market
          if Market.player_market?(market_id) && player_data.dig(:player_markets, market_id, identifier)
            player_data[:player_markets][market_id][identifier][:status] = '0'
          elsif data.dig(:markets, market_id, identifier)
            data[:markets][market_id][identifier][:status] = '0'
          end
        end
        [data, player_data]
      end

      def fetch_odds_data
        [fetch_market_data_from_cache, fetch_player_market_data_from_cache]
      end

      def fetch_market_data_from_cache
        Utility::MarketUtility.market_odds_data(@match.id)
        # Rails.cache.fetch(Utility::Cache.odds_change_cache_key(@match.id)) || { markets: {} }
      end

      def fetch_player_market_data_from_cache
        Utility::MarketUtility.player_markets_odds_data(@match.id)
        # Rails.cache.fetch(Utility::Cache.odds_change_cache_key(@match.id)) || { markets: {} }
      end

      def process_data(markets)
        markets.each do |market|
          next unless Constants::SOCCER_SUPPORTED_MARKETS.include?(market[:id])
          identifier = identifier_value(market)
          Array.wrap(market[:outcome]).each do |outcome_data|
            ::Betting::DirectBetResult.run(
              data: {
                match_uid: @match_uid, outcome_data: outcome_data,
                market: market, specifiers: specifier_data(market[:specifiers]),
                identifier: identifier, result:  outcome_data[:result].to_f,
                void_factor: outcome_data[:void_factor].to_f
              }
            )
            # match_outcome = fetch_match_outcome(market, outcome_data, specifiers).first
            # if match_outcome.blank?
            # else
            #   process_match_outome(match_outcome, outcome_data)
            # end
          end
        end
      end

      # def process_match_outome(match_outcome, outcome_data)
      #   match_outcome.result = outcome_data[:result].to_f
      #   match_outcome.void_factor = outcome_data[:void_factor].to_f if outcome_data[:void_factor].present?
      #   match_outcome.save!
      #   Betting::BetResult.run(match_outcome: match_outcome)
      # end

      def fetch_match_outcome(market, outcome_data, specifiers)
        match_outcome = MatchOutcome.where(match_uid: @match_uid,
                                           market_uid: market[:id],
                                           outcomeable_uid: outcome_data[:id],
                                           outcomeable_type: 'Outcome')
        # TODO : check where multiple specifier comes
        match_outcome.select { |outcome| outcome.specifier_text == specifiers.to_h }
      end

      def identifier_value(market)
        specifier_key(market[:specifiers].presence || '1').to_i
      end

      def remove_bets_on_hold(markets)
        return if @match.blank?
        markets = Market.select('id, uid').where(uid: Array.wrap(markets).map { |market| market[:id] })
        Bet&.hold&.where(match_id: @match.id, market_id: markets.pluck(:id))&.destroy_all
      end
    end
  end
end
