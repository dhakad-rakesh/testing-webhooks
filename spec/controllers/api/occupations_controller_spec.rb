require 'rails_helper'

describe Api::OccupationsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:occupation) { FactoryBot.create(:occupation) }

  context 'GET /api(/v:version)/occupations' do
    it 'should not return occupations without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return occupations' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['occupations'].present?).to be_truthy
    end
  end
end
