require 'rails_helper'

describe Api::BetsController do
  include_context 'common data'
  let(:token) { user.generate_access_token.token }

  describe 'POST :create' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return 401 status code with invalid token' do
      request.env['HTTP_AUTHORIZATION'] = 'Bearer invalid toekn'
      post :create, params: { bet_slips: [bet_slip] }
      expect(response.status).to eq(401)
    end

    it 'should return match not found error with invalid match id' do
      bet_slip[:match_id] = 999
      allow(GammabetSetting).to receive(:betting_allowed?).and_return(true)
      post :create, params: { bet_slips: [bet_slip] }

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to eq('[] matches not found.')
    end

    it 'it should return error if data for market and odds is not present in cache' do
      allow(GammabetSetting).to receive(:betting_allowed?).and_return(true)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')
      post :create, params: { bet_slips: [bet_slip] }
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['message'].flatten.first['errors']).to eq(['Market not found', 'Odds not valid'])
    end

    it 'should return success with correct betslip and valid token' do
      stub_cache_fetch
      allow(Rails.cache).to receive(:fetch).with(:betting_allowed).and_return(true)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')
      post :create, params: { bet_slips: [bet_slip] }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Bets created!')
    end
  end

  def stub_cache_fetch
    (1..3).each do |cache_id|
      allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
    end
  end
end
