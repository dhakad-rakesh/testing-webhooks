require 'rails_helper'

describe Api::DialectsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:dialect) { FactoryBot.create(:dialect) }

  context 'GET /api(/v:version)/dialects' do
    it 'should not return dialects without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return dialects' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['dialects'].present?).to be_truthy
    end
  end
end
