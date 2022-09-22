require 'rails_helper'

describe Api::LedgersController do
  include_context 'common data'
  let!(:token) { user.generate_access_token.token }

  context 'GET /api(/v:version)/ledgers' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      wallet.update(available_amount: 5000)

      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should return user ledgers' do
      wallet.update(available_amount: 1000)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      expect(Bet.count).to be(0)
      expect(wallet.ledgers.count).to be(0)
      betprocess.call

      get :index
      result = JSON.parse(response.body)

      expect(response.status).to be(200)
      expect(result['ledgers'].count).to be(1)
    end
  end
end
