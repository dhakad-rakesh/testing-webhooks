RSpec.shared_context 'common data', shared_context: :metadata do
  let(:user) { FactoryBot.create(:user) }
  let!(:match) { FactoryBot.create(:match) }
  let!(:market) { FactoryBot.create(:market) }
  let!(:outcome) { FactoryBot.create(:outcome) }
  let(:identifier) { Time.zone.now.to_i }
  let(:wallet) { user.point_wallet }

  let(:bet) do
    FactoryBot.create(
      :bet, user: user, market: market, outcome: outcome, match: match, wallet: wallet
    )
  end

  let!(:match_outcome) do
    MatchOutcome.create(
      market: market, outcomeable: outcome, odds: '1.3',
      identifier: identifier, specifier_text: {}, match: match, status: '1'
    )
  end

  let(:bet_slip) do
    {
      match_id: match.id, market_id: market.id, outcome_id: outcome.id,
      odds: '1.3', stake: 500, identifier: match_outcome.identifier
    }
  end

  let(:cached_response) do
    { markets:
      { market.id =>
        { identifier =>
          { name: market.name,
            outcomes: { outcome.id =>
                        { name: '{$competitor1}',
                          class_name: 'Outcome',
                          odd_type: nil,
                          odds: 1.3,
                          status: '1',
                          play_number: 1 } },
            specifier: {},
            status: '1' } } } }
  end

  let(:cache_key_1) { ["match_id_#{match.id}", :odds_data] }
  let(:cache_key_2) { ["match_#{match.id}_market_#{market.id}_#{market.name}_name"] }
  let(:cache_key_3) { ["match_#{match.id}_market_#{market.id}_#{outcome.name}_name"] }
end

RSpec.configure do |rspec|
  rspec.include_context 'common data', include_shared: true
end
