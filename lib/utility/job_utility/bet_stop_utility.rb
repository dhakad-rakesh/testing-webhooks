module Utility
  module JobUtility
    module BetStopUtility
      module InstanceMethods
        def update_markets_status(match)
          old_data = fetch_or_generate_old_data(match)
          new_data = old_data.dup
          old_data[:markets].each do |market_data|
            market_data[1].each do |identifier|
              identifier[1][:status] = '-1'
            end
          end
          new_data[:markets].merge!(old_data[:markets])
          generate_cache_data(new_data, match)
          new_data
        end

        def update_player_markets_status(match)
          old_data = Utility::MarketUtility.player_markets_odds_data(match.id)
          new_data = old_data.dup
          old_data[:player_markets].each do |market_data|
            market_data[1].each do |identifier|
              identifier[1][:status] = '-1'
            end
          end
          new_data[:player_markets].merge!(old_data[:player_markets])
          generate_cache_data(new_data, match)
          new_data
        end

        private

        def fetch_or_generate_old_data(match)
          OddStore.new(match.id).odds_data
        end

        def generate_cache_data(new_data, match)
          OddStore.new(match.id).odds_data = new_data
        end

        def update_markets_status_half(match, actual_status)
          old_data = OddStore.new(self.id).odds_data
          new_data = old_data.dup

          half_markets =
            old_data[:markets].select do |a|
              first_half_markets(actual_status).include?(a)
            end

          half_markets.each do |market_data|
            market_data[1].each do |identifier|
              identifier[1][:status] = '-1'
            end
          end
          new_data[:markets].merge!(half_markets)
          write_data_to_cache(match, new_data)
          new_data
        end
      end

      def first_half_markets(actual_status)
        Market.soccer_filters[:both][fetch_half(actual_status)][:all]
      end

      def fetch_half(actual_status)
        actual_status == '31' ? :first_half : :both
      end

      def write_data_to_cache(match, data)
        OddStore.new(self.id).odds_data = data
      end

      def self.included(receiver)
        receiver.send :include, InstanceMethods
      end
    end
  end
end
