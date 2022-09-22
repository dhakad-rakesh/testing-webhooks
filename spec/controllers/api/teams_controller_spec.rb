require 'rails_helper'

describe Api::TeamsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:match) { FactoryBot.create(:match) }

  context 'GET /api(/v:version)/teams' do
    it 'should not return teams without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return teams with valid match' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      match.teams << match.tournament.teams
      get :index, params: { match_id: match.id }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['teams'].present?).to be_truthy
    end

    it 'should not return teams with invalid match' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      match.teams << match.tournament.teams
      get :index, params: { match_id: 'xyz' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['error']).to eq('Match not found')
    end
  end
end
