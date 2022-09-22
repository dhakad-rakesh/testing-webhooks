require 'rails_helper'

describe Api::MatchesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:match) { FactoryBot.create(:match) }
  include_context 'common data'

  context 'GET /api(/v:version)/matches' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return matches that are started' do
      match.update(status: 'started', schedule_at: Time.zone.now)
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_truthy
    end

    it 'should not return matches that are not started' do
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_falsey
    end
  end

  context 'GET /api(/v:version)/matches/:id/' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return match with valid id' do
      get :show, params: { id: match.id }

      result = JSON.parse(response.body)['match']
      expect(response.status).to be(200)
      expect(result['id']).to be(match.id)
      expect(result['status']).to eq(match.status)
    end

    it 'should not return match with invalid match_id' do
      get :show, params: { id: 'xyz' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['matches'].present?).to be_falsey
    end
  end

  # Currently API is not in use
  # context 'GET /api(/v:version)/matches/:id/live_score ' do
  #   before(:each) do
  #     request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
  #   end

  #   it 'should return live_score when match is valid' do
  #     match.update(status: 'started')
  #     get :live_score, params: { id: match.id }

  #     result = JSON.parse(response.body)
  #     expect(response.status).to be(200)
  #     expect(result['matches'].present?).to be_truthy
  #   end

  #   it 'should return live_score when match not started' do
  #     get :live_score, params: { id: match.id }

  #     result = JSON.parse(response.body)
  #     expect(response.status).to be(404)
  #     expect(result['message']).to eq('no live matches')
  #   end
  # end
  context 'GET /api(/v:version)/tournaments/:id/matches/my_bets ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      wallet.update(available_amount: 5000)

      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should return matches of user where they applies for the bet' do
      wallet.update(available_amount: 1000)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      betprocess.call

      get :my_bets, params: { id: match.tournament.id }
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_truthy
    end
  end

  context 'GET /api(/v:version)/matches/:id/odds_summary' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return odds_summary' do
      get :odds_summary, params: { id: match.id, market_id: match.markets.first.id }

      result = JSON.parse response.body
      expect(response.status).to be(200)
      expect(result).to include('outcomes')
    end
  end
end
