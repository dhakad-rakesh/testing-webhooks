module Lsports
  module Format
    class InplayOdds
      attr_accessor :data

      def initialize(data = [])
        @data = data
      end

      def call
        format_api_response
      end

      def match_markets(markets_data, match_uid)
        markets(markets_data, match_uid)
      end

      def match_bets(providers)
        filter_providers(providers).last
      end

      def match_livescore; end

      private

      def format_api_response
        formated_data = []
        data[:Body][:Events].each do |fixture|
          fixture_id = fixture[:FixtureId]
          markets = fixture[:Markets]

          match = Match.find_by uid: fixture_id.to_s

          next if match.blank?

          formated_data << {
            product: match.tournament.try(:uid), # league uid
            event_id: match.uid,
            timestamp: data[:Header][:ServerTimestamp],
            odds: odds(markets, match)
          }
        end

        formated_data.compact
      end

      def odds(markets_data, match)
        { markets: markets(markets_data, match) }
      end

      def markets(markets_data, match_uid)
        formated_market_data = {}
        # ordered_markets = match.markets_ordering(markets_data)

        # return {} if ordered_markets.blank?

        markets_data.each do |market_data|
          market_id = market_data[:Id].to_s
          _market = market(market_data, market_id, market_data[:Providers])
          next if _market.blank?
          # create_sport_markets_mapping!(market_id: market_id, match: match)
          formated_market_data[market_id] = _market
        end
        formated_market_data
      end

      def create_sport_markets_mapping!(market_id:, match:)
        market = Market.find_by uid: market_id
        SportMarket.find_or_create_by(market: market, sport: match.sport, priority: market.priority) if market
      end

      def specifier(_data = nil)
        '49'
      end

      def market(data, market_id, providers)
        provider, filtered_providers = *filter_providers(providers)

        return nil if filtered_providers.blank?

        format_data(data, market_id, outcome(filtered_providers, market_id), provider, filtered_providers)
      end

      def format_data(data, market_id, outcomes, provider, filtered_providers)
        return nil if outcomes.blank?

        {
          specifier => {
            name: data[:Name],
            # name: market_name(market_id),
            uid: market_id,
            status: status(filtered_providers),
            specifier: {},
            outcomes: outcomes,
            provider: provider,
            handicaps: group_outcomes(outcomes),
            categories: categories(market_id)
          }
        }
      end

      def status(filtered_providers)
        _status = filtered_providers[0][:Bets].map { |k| k[:Status] }.uniq
        return _status.uniq.map { |s| Bet.ls_status(s) }.join(', ') if _status.length > 1

        Bet.ls_status(_status.first)
      end

      def outcome(providers, market_id)
        outcomes_data(providers[0][:Bets], market_id)
      end

      def outcomes_data(bets, _market_id)
        outcomes = {}
        bets = order_outcomes(bets, _market_id) if Constants::MARKET_OUTCOME_ORDER.keys.include?(_market_id)
        bets.each do |bet|
          outcomes[bet[:Id].to_s] = {
            uid: bet[:Id].to_s,
            odds: bet[:Price],
            name: bet[:Name],
            handicap: handicap_name(bet),
            status: Bet.ls_status(bet[:Status]),
            last_update: bet[:LastUpdate]
          }
        end
        outcomes
      end

      def order_outcomes(bets, market_id)
        ordered_bets = []
        bet_map = generate_bet_map(bets)
        Constants::MARKET_OUTCOME_ORDER[market_id][:outcomes_name].each do |name|
          ordered_bets << bet_map[name] if bet_map[name]
        end
        ordered_bets
      end

      def generate_bet_map(bets)
        bet_map = {}
        bets.each do |bet|
          bet_map[bet['Name']] = bet 
        end
        bet_map
      end

      def handicap_name(bet)
        bet[:BaseLine]
      end

      def outcome_name(name, info)
        name = name.gsub(info[:home_team], 'Home')
        name = name.gsub(info[:away_team], 'Away')
        name
      end

      def filter_providers(providers)
        name = 'Bet365'
        data = filter_providers_by_name(providers, name)
        return [name, data]

        # name = 'BWin'
        # data = filter_providers_by_name(providers, name)
        # [name, data]
      end

      def filter_providers_by_name(providers, name)
        providers.select { |p| p[:Name] == name }
      end

      def market_name(market_id)
        Rails.cache.fetch("markets_name_#{market_id}") do
          Market.find_by_uid(market_id).try(:fancy_name)
        end
      end

      def group_outcomes(outcomes)
        return -1 unless outcomes.values.first[:handicap].present?
        grouped_outcomes = {}
        outcomes.values.each do |outcome|
          grouped_outcomes[outcome[:handicap]] ||= {}
          grouped_outcomes[outcome[:handicap]]["-#{outcome[:uid]}"] = outcome
        end
        grouped_outcomes
      end

      def categories(market_id)
        # names = Market.includes(:categories).find_by_uid(market_id).categories.pluck(:name)
        names = Market::CATEGORIES_MAP[market_id]
        category_names(names)
      end

      def category_names(names)
        names = ['others'] if names.blank?
        Hash[names.zip names]
      end
    end
  end
end
