module Betradar
  module MarketOddsUtil
    module InstanceMethods
      def specifier_key(specifier_text)
        specifier_text.split('').map(&:ord).join('')
      end

      def market_name(market, match, specifier_text)
        MatchMarketOutcomeName.call((market&.display_name || market&.name).capitalize,
          match, market.id, specifier_text.to_h)
      end

      def specifier_data(specifiers)
        @specifier_text = specifiers.present? ? specifiers.split('|').map { |a| a.split('=') } : nil
      end

      def invalid_match_for_odds_change?(match)
        match.blank? || match.non_supported_tournament? || !match.enabled
      end

      def invalid_gs_match_for_odds_change?(match)
        match.blank? || match.non_supported_tournament?
      end

      def remove_pre_log
        return unless @match.pre_match_odds && @routing_key.split('.').slice(1, 2).join('.') == '-.live'
        @match.pre_match_odds = false
        data = OddStore.new(@match.id).odds_data
        Market.pre_match_markets.pluck(:id).each { |id| data[:markets].delete(id) }
        OddStore.new(@match.id).odds_data = data
        @match.save
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
