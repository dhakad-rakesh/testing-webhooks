require 'rails_helper'

describe Api::SportsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:match) { FactoryBot.create(:match) }

  context 'GET /api(/v:version)/sports' do
    it 'should not return sports without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return sports' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['sports'].present?).to be_truthy
    end
  end

  context 'GET /api(/v:version)/sports/:id/matches' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return matches of a sport' do
      get :matches, params: { id: match.sport.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_truthy
    end

    it 'should not return matches of a invalid sport' do
      get :matches, params: { id: 'xyz' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['matches'].present?).to be_falsey
    end
  end

  context 'GET /api(/v:version)/sports/:id/' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return sport with valid id' do
      sport = match.sport
      get :show, params: { id: sport.id }

      result = JSON.parse(response.body)['sport']
      expect(response.status).to be(200)
      expect(result['id']).to be(sport.id)
      expect(result['name']).to eq('Football')
    end

    it 'should not return sport with invalid sport id' do
      get :show, params: { id: 'xyz' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['matches'].present?).to be_falsey
    end
  end

  context 'GET /api(/v:version)/sports/:id/live_scores ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return live_score when sport is valid' do
      match.update(status: 'started')
      sport = match.sport
      get :live_scores, params: { id: sport.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['matches'].present?).to be_truthy
    end

    it 'should return live_score when match not started' do
      sport = match.sport
      get :live_scores, params: { id: sport.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['message']).to eq('no live matches')
    end
  end
end
