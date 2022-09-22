require 'rails_helper'

describe Api::Users::PreferencesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:tournament) { FactoryBot.create(:tournament) }
  let!(:league) { FactoryBot.create(:tournament, :league, name: 'Series A') }
  let!(:cup) { FactoryBot.create(:tournament, :cup) }

  context 'GET /api(/v:version)/users/preferences' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return user preferences when token is valid' do
      get :show
      result = JSON.parse(response.body)['user']

      expect(result['id']).to eq(user.id)
      expect(result['first_name']).to eq(user.first_name)
      expect(result['last_name']).to eq(user.last_name)
      expect(result['email']).to eq(user.email)
      expect(result['username']).to eq(user.username)
      expect(result['gender']).to eq(user.gender)
      expect(result['favourite_team']).to eq(user.favourite_team)
      expect(result['favourite_league']).to eq(user.favourite_league)
      expect(response.status).to be(200)
    end

    it 'should not return user preferences when token is invalid' do
      token = 'Bearer 1111'
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      get :show

      expect(response.status).to be(401)
    end
  end

  context 'PATCH /api(/v:version)/users/preferences' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should update user preferences when params are valid' do
      expect(user.favourites.count).to be(0)
      expect(user.first_name).to be_nil
      expect(user.last_name).to be_nil

      patch :update, params: {
        first_name: 'first name',
        last_name: 'last name',
        favourite_league: league.name
      }

      expect(response.status).to be(200)
      user.reload
      expect(user.favourites.count).to be(1)
      expect(user.first_name).to eq('first name')
      expect(user.last_name).to eq('last name')
    end

    it 'should not update user preferences when params are invalid' do
      patch :update, params: {
        first_name: 'first name',
        last_name: 'last name',
        username: nil
      }

      expect(response.status).to be(404)
    end
  end
end
