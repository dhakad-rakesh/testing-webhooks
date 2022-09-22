module GS
  class ResolveMarket
    include SpecifierMarket
    include NonSpecifierMarket

    def initialize(options = {})
      match = options[:match]
      @sport = match.sport
      @market = options[:market]
    end

    def resolve(match_data, specifier_text = nil)
      #return unless can_resolve?(match_data)
      if specifier_text.present?
        #return fetch_sequence_goal(match_data, specifier_text) if @market.uid == "1778"
        send(formart_market_name, match_data, specifier_text)
      else
        send(formart_market_name, match_data)
      end
    end

    private

    def can_resolve?(match_data)
      (%w[ht half-time halftime].include?(match_data[:status].downcase) && Constants::HALF_TIME_MARKETS.include?(@market.name) ||
        %w[ft full-time fulltime Pen.].include?(match_data[:status].downcase) && Constants::FULL_TIME_MARKETS.include?(@market.name))
    end

    def formart_market_name
      'fetch_' + @market.name.downcase.gsub(/[^a-zA-Z0-9]/, "_")
    end
  end
end
