module Utility::JobUtility::OutcomeGenerationUtility
  def fetch_and_process_data(markets, variant)
    data = { markets: {} }
    filter_markets(markets, variant)
    @number = 0
    @markets_data.each do |market_data|
      @market = @all_markets.detect { |a| a.uid == market_data[:id] }
      outcome_info = process_outcomes(market_data[:outcome], market_data)
      data[:markets][@market.id] ||= {}
      data[:markets][@market.id] = market_infomation(data[:markets][@market.id],
        outcome_info, market_data[:status], market_data[:specifiers])
    end
    data
  end

  def market_infomation(data_market, outcome_info, status, specifiers)
    @specifier_text = specifier_data(specifiers).to_h
    data_market.merge(
      specifier_key(specifiers.presence || '1').to_i => {
        name: market_name(@market, @match, @specifier_text).to_s, uid: @market.uid, status: status,
        specifier: @specifier_text, outcomes: outcome_info
      }.merge(player_informations)
    )
  end

  def player_informations
    return {} unless Constants::SOCCER_SUPPORTED_PLAYER_MARKETS.include?(@market.uid)
    { player_id: TeamPlayer.fetch_by_uid('sr:player:' + @specifier_text['variant'].split(':').last)&.id }
  end

  def process_outcomes(outcomes_data, market_data)
    outcome_info = {}
    Array.wrap(outcomes_data).each do |outcome_data|
      @number = (@number < 1000 ? @number + 1 : 0)
      outcomes_id, outcomes_data = OddChange.run!(
        odds_change_params(market_data).merge(
          outcome_data: outcome_data, outcomes: @market.outcomes.to_a, play_number: @number
        )
      )
      next unless outcome_data[:active] == '1'
      outcome_info[outcomes_id] = outcomes_data
    end
    outcome_info
  end

  def odds_change_params(market_data)
    { market_id: @market.id, match: @match, routing_key: @routing_key,
      specifiers: specifier_data(market_data[:specifiers]).to_h }
  end
end
