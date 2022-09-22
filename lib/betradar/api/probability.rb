module Api
  module Probability
    # Sport event probabilities
    # Get probabilities for a sport event.
    def event_probabilities(event_id, event_type = 'sr:match')
      get("probabilities/#{event_type}:#{event_id}")
    end

    # Market probabilities
    def market_probabilities(market_id, event_id, event_type = 'sr:match')
      get("probabilities/#{event_type}:#{event_id}/#{market_id}")
    end

    # Market probabilities with specifiers
    def market_probabilities_with_specifiers(market_id, market_specifier, event_id, event_type = 'sr:match')
      get("probabilities/#{event_type}:#{event_id}/#{market_id}/#{market_specifier}")
    end
  end
end
