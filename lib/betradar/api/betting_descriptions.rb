module Api
  module BettingDescriptions
    # Market descriptions
    # Defines all currently available markets xml schema
    def market_descriptions(mapping = true)
      get("descriptions/en/markets.xml?include_mappings=#{mapping}")
    end

    # Void Reasons
    # The different reasons for why we void a market. Check void_reason in settlements.
    def void_reasons
      get('descriptions/void_reasons.xml')
    end

    # Betstop descriptions
    def betstop_descriptions
      get('descriptions/betstop_reasons.xml')
    end

    # Betting status
    def betting_status
      get('descriptions/betting_status.xml')
    end

    # Match status
    # Describes all match statuses.
    def match_status
      get('descriptions/en/match_status.xml')
    end

    # Outcome Reasons
    def outcome_reasons
      get('descriptions/outcome_reasons.xml')
    end

    # Variant Market Descriptions
    def variant_market_descriptions(market_id, variant_urn, product = nil)
      product = "#{product}/" if product
      get("#{product}descriptions/en/markets/#{market_id}/variants/#{variant_urn}")
    end

    # Available producers
    def producers
      get('descriptions/producers.xml')
    end
  end
end
