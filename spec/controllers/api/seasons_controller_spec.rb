require 'rails_helper'

describe Api::SeasonsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:season) { FactoryBot.create(:season) }

  context 'GET /api(/v:version)/seasons' do
    it 'should not return seasons without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return seasons' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['seasons'].present?).to be_truthy
    end
  end
end
