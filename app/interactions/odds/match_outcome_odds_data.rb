module Odds
  class MatchOutcomeOddsData < Odds::Base
    set_callback :validate, :before, -> { initialize_objects }
    object :match

    def execute
      # Is generating only one outcome for market
      data = { markets: {} }
      @number = 0
      @active_markets.each do |market|
        market.active_match_outcomes(match).each do |match_outcome|
          @number += 1
          outcomes_id, outcomes_data = OddChange.run!(
            odds_change_params(match_outcome)
          )
          next unless outcomes_data[:status] == '1'
          data[:markets][market.id] =
            market_data(
              data[:markets][market.id] || {},
              match_outcome: match_outcome, outcomes_id: outcomes_id,
              outcomes_data: outcomes_data, market: market,
              specifier_text: match_outcome.specifier_text.to_h,
              market_status: match_outcome.market_status,
              identifier: match_outcome.identifier
            )
        end
      end
      data
    end

    private

    def market_data(market_info, args = {})
      market = args[:market]
      specifier_text = args[:specifier_text]
      identifier = args[:identifier]
      outcomes = market_info.dig(identifier, :outcomes) || {}
      outcomes[args[:outcomes_id]] = args[:outcomes_data]
      market_info.merge(
        identifier => {
          name: market_name(market, match, specifier_text), outcomes: outcomes,
          specifier: specifier_text, status: args[:market_status], uid: market.uid
        }
      )
    end

    def initialize_objects
      @match_outcomes = match.match_outcomes.includes(:market) rescue []
      market_ids = @match_outcomes.map(&:market_id).uniq
      @active_markets = match.active_markets.includes(:match_outcomes)
                             .where(id: market_ids) rescue []
    end

    def odds_change_params(match_outcome)
      {
        market_id: match_outcome.market_id,
        match: match,
        specifiers: match_outcome.specifier_text.to_h,
        outcome_data: {
          id: match_outcome.outcomeable_uid,
          odds: match_outcome.odds.to_f,
          'active' => match_outcome.status
        },
        play_number: @number,
        from_match_outcome: true
      }
    end
  end
end
