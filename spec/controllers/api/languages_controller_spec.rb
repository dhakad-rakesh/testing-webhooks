require 'rails_helper'

describe Api::LanguagesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:language) { FactoryBot.create(:language) }

  context 'GET /api(/v:version)/languages' do
    it 'should not return languages without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return languages' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['languages'].present?).to be_truthy
    end
  end
end
