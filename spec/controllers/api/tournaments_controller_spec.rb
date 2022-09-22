require 'rails_helper'

describe Api::TournamentsController do
  # let!(:tournament) { FactoryBot.create(:tournament) }
  include_context 'common data'
  let!(:match) { FactoryBot.create(:match) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }

  context 'GET /api(/v:version)/tournaments' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return tournaments according to the sport' do
      get :index, params: { sport_id: Sport.first.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('tournament', 'pending', 'league')
    end

    it 'should return tournaments' do
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('tournament', 'pending', 'league')
    end
  end

  context 'GET  /api(/v:version)/tournaments/:id' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return the tournament' do
      tournament = Tournament.first
      get :show, params: { id: tournament.id }

      expect(response.status).to be(200)
      result = JSON.parse(response.body)['tournament']
      expect(result['id']).to be(tournament.id)
      expect(result['name']).to eq(tournament.name)
      expect(result['tournament_type']).to eq(tournament.tournament_type)
      expect(result['uid']).to eq(tournament.uid)
      expect(result).to include('sport')
    end

    it 'should not found tournament with invalid id' do
      get :show, params: { id: 'xyz' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['message']).to eq('Tournament not found')
    end
  end

  context 'GET /api(/v:version)/tournaments/:id/teams' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return teams of a valid tournament' do
      tournament = Tournament.first
      get :teams, params: { id: tournament.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['teams'].present?).to be_truthy
    end

    it 'should return teams for the invalid tournament' do
      get :teams, params: { id: 'abc' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['message']).to eq('Tournament not found')
    end
  end

  context 'GET /api(/v:version)/tournaments/:id/matches' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should not return matches for the invalid tournament' do
      get :matches, params: { id: 'abc' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['message']).to eq('Tournament not found')
    end

    it 'should return matches for the valid tournament' do
      tournament = Tournament.first
      get :matches, params: { id: tournament.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_truthy
    end
  end

  context 'GET /api(/v:version)/tournaments/my_bets' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      wallet.update(available_amount: 5000)

      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should return bets of signed_in user' do
      wallet.update(available_amount: 1000)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      betprocess.call

      get :my_bets
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['tournaments'].present?).to be_truthy
    end
  end
end
