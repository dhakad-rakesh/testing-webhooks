require 'rails_helper'

describe Api::OrganizationsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:organization) { FactoryBot.create(:organization) }

  context 'GET /api(/v:version)/organizations' do
    it 'should not return organizations without login' do
      get :index
      expect(response.status).to be(401)
    end

    it 'should return organizations' do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['organizations'].present?).to be_truthy
    end
  end
end
