require 'rails_helper'

describe Api::CountriesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:match) { FactoryBot.create(:match) }

  context 'GET /api(/v:version)/countries' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return countries' do
      FactoryBot.create(:venue, match_id: match.id)
      get :index

      result = JSON.parse response.body
      expect(response.status).to be(200)
      expect(result['countries'].present?).to be(true)
    end

    it 'should return countries using parameters continent' do
      FactoryBot.create(:venue, match_id: match.id)
      get :index, params: { continent: 'south america' }

      result = JSON.parse response.body
      expect(response.status).to be(200)
      expect(result['countries'].present?).to be(true)
    end
  end

  context 'GET /api(/v:version)/countries/:id/cities' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return cities' do
      country = CS.countries.first[0]
      get :cities, params: { id: country }

      expect(response.status).to be(200)
    end
  end
end
