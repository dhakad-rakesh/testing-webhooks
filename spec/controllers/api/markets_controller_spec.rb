require 'rails_helper'

describe Api::MarketsController do
  include_context 'common data'
  let!(:token) { user.generate_access_token }
  let!(:token) { user.generate_access_token.token }

  context 'GET /api(/v:version)/matches/:match_id/markets' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      wallet.update(available_amount: 5000)
      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should not return markets of invalid match' do
      get :index, params: { match_id: 'xyz' }
      result = JSON.parse(response.body)

      expect(result['message']).to eq('Match not found')
      expect(response.status).to be(404)
    end

    it 'should markets of a valid match' do
      get :index, params: { match_id: match.id }
      result = JSON.parse(response.body)
      expect(result['markets'].present?).to be(true)
      expect(response.status).to be(200)
    end
  end

  context 'GET /api(/v:version)/matches/:match_id/markets/filters' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      wallet.update(available_amount: 5000)
      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should filters of markets' do
      get :filters, params: { match_id: match.id }

      result = JSON.parse(response.body)
      expect(result['keys'].present?).to be(true)
      expect(response.status).to be(200)
    end
  end
end
