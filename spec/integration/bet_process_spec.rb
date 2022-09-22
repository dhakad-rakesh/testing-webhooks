require 'rails_helper'
describe BetProcess do
  include_context 'common data'

  let(:cache_key_4) { ["match_#{match.id}_market_#{market.id}_specifier_ids"] }

  before(:each) do
    wallet.update(available_amount: 1000)
    (1..4).each do |cache_id|
      allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
    end

    Constants.const_set(:SOCCER_SUPPORTED_MARKETS, [market.uid])
    allow_any_instance_of(Match).to receive(:betting_status).and_return('0')
    @betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
  end

  it 'User should win the bet' do
    expect(user.bets.count).to be(0)
    expect(wallet.ledgers.count).to be(0)
    @betprocess.call

    expect(user.bets.count).to be(1)
    expect(wallet.ledgers.count).to be(1)
    bet = user.bets.first
    expect(bet.status).to eq('pending')
    parsed_xml = xml(match: match, market: market, outcome: outcome, result: 1)
    BR::AMQP::FeedResultJob.perform_now(parsed_xml)
    expect(wallet.reload.available_amount).to eq(1150)
    expect(bet.reload.status).to eq('won')
  end

  it 'User should lose the bet' do
    expect(user.bets.count).to be(0)
    expect(wallet.ledgers.count).to be(0)
    @betprocess.call

    expect(user.bets.count).to be(1)
    expect(wallet.ledgers.count).to be(1)
    bet = user.bets.first
    expect(bet.status).to eq('pending')
    parsed_xml = xml(match: match, market: market, outcome: outcome, result: 0)
    BR::AMQP::FeedResultJob.perform_now(parsed_xml)
    expect(wallet.reload.available_amount).to eq(500)
    expect(bet.reload.status).to eq('lost')
  end

  def xml(data)
    "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
    <bet_settlement certainty=\"1\" product=\"1\" event_id=\"#{data[:match].uid}\" timestamp=\"1533856599607\">
      <outcomes>
        <market id=\"#{data[:market].uid}\">
          <outcome id=\"#{data[:outcome].uid}\" result=\"#{data[:result]}\"/>
        </market>
      </outcomes>
    </bet_settlement>"
  end
end
