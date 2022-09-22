require 'rails_helper'

describe Api::FavouritesController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:tournament) { FactoryBot.create(:tournament) }
  let!(:match) { FactoryBot.create(:match) }

  context 'POST api(/v:version)/sports/:sport_id/favourites' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should create favourite sport of the signed_in user with valid sport_id' do
      expect(user.favourites.count).to be(0)
      post :create, params: { sport_id: tournament.sport_id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Marked favourite')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(200)
    end

    it 'should not create favourite sport of the signed_in user with invalid sport_id' do
      expect(user.favourites.count).to be(0)

      post :create, params: { sport_id: 'xyz' }
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(400)
    end
  end

  context 'POST api(/v:version)/teams/:team_id/favourites' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should create favourite team of the signed_in user with valid team_id' do
      match.teams << match.tournament.teams
      expect(user.favourites.count).to be(0)
      post :create, params: { team_id: match.teams.first.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Marked favourite')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(200)
    end

    it 'should not create favourite team of the signed_in user with invalid team_id' do
      expect(user.favourites.count).to be(0)

      post :create, params: { team_id: 'xyz' }
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(400)
    end
  end

  context 'POST api(/v:version)/tournaments/:tournament_id/favourites' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should create favourite tournament of the signed_in user with valid tournament_id' do
      match.teams << match.tournament.teams
      expect(user.favourites.count).to be(0)
      post :create, params: { tournament_id: match.tournament.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Marked favourite')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(200)
    end

    it 'should not create favourite tournament of the signed_in user with invalid tournament_id' do
      expect(user.favourites.count).to be(0)

      post :create, params: { tournament_id: 'xyz' }
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(400)
    end
  end

  context 'DELETE api(/v:version)/sports/:sport_id/favourites/:id ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should delete favourite sport of the user' do
      Favourites.run(favouriteable_type: tournament.sport.class.name, favouriteable_id: tournament.sport_id, user: user)
      expect(user.favourites.count).to be(1)
      delete :destroy, params: { sport_id: tournament.sport_id, id: user.favourites.first.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Succesfully destroy favourite')
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(200)
    end

    it 'should not delete favourite sport of user with invalid' do
      Favourites.run(favouriteable_type: tournament.sport.class.name, favouriteable_id: tournament.sport_id, user: user)
      expect(user.favourites.count).to be(1)

      delete :destroy, params: { sport_id: tournament.sport_id, id: 'xyz' }
      result = JSON.parse(response.body)
      expect(result['message']).to eq('Favourite not found')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(404)
    end
  end

  context 'DELETE api(/v:version)/teams/:team_id/favourites/:id ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should delete favourite team of the user' do
      match.teams << match.tournament.teams
      Favourites.run(favouriteable_type: Team.name, favouriteable_id: match.teams.first.id, user: user)
      expect(user.favourites.count).to be(1)
      delete :destroy, params: { team_id: match.teams.first.id, id: user.favourites.first.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Succesfully destroy favourite')
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(200)
    end

    it 'should not delete favourite team of user with invalid' do
      match.teams << match.tournament.teams
      Favourites.run(favouriteable_type: Team.name, favouriteable_id: match.teams.first.id, user: user)
      expect(user.favourites.count).to be(1)

      delete :destroy, params: { team_id: match.teams.first.id, id: 'xyz' }
      result = JSON.parse(response.body)
      expect(result['message']).to eq('Favourite not found')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(404)
    end
  end

  context 'DELETE api(/v:version)/tournaments/:tournament_id/favourites/:id ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should delete favourite tournament of the user' do
      match.teams << match.tournament.teams
      Favourites.run(favouriteable_type: tournament.class.name, favouriteable_id: tournament.id, user: user)
      expect(user.favourites.count).to be(1)
      delete :destroy, params: { tournament_id: tournament.id, id: user.favourites.first.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Succesfully destroy favourite')
      expect(user.favourites.count).to be(0)
      expect(response.status).to be(200)
    end

    it 'should not delete favourite tournament of user with invalid' do
      Favourites.run(favouriteable_type: Tournament.name, favouriteable_id: tournament.id, user: user)
      expect(user.favourites.count).to be(1)

      delete :destroy, params: { tournament_id: tournament.id, id: 'xyz' }
      result = JSON.parse(response.body)
      expect(result['message']).to eq('Favourite not found')
      expect(user.favourites.count).to be(1)
      expect(response.status).to be(404)
    end
  end
end
