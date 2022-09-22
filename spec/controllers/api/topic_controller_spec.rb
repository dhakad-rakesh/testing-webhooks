require 'rails_helper'

describe Api::TopicsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:topic) { FactoryBot.create(:topic) }

  context 'GET /api(/v:version)/topics' do
    it 'should not return topics without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return topics' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['topics'].present?).to be_truthy
    end
  end
end
