require 'rails_helper'

describe Api::PreferencesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }

  context 'GET /api(/v:version)/preferences' do
    it 'should return preferences' do
      get :index
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('languages', 'dialect', 'countries', 'odds_formats')
    end
  end
end
