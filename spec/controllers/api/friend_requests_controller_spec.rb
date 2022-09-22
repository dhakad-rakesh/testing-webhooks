require 'rails_helper'

describe Api::FriendRequestsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:friend) { FactoryBot.create(:user, username: 'abc888', email: 'abc888@example.com', password: 'Gammabet@123') }

  context 'POST /api(/v:version)/friend_requests' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should create friend_request with valid freind_id' do
      post :create, params: { friend_id: friend.id }
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq('Friend request successfuly sent.')
    end

    it 'should not create friend_request when alredy applied' do
      user.friend_requests.create(friend: friend)
      post :create, params: { friend_id: friend.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Friend request could not be sent because Friend has already been taken.')
      expect(response.status).to be(400)
    end

    it 'should not create friend_request with invalid friend_id' do
      post :create, params: { friend_id: 'xyz' }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Friend not found.')
      expect(response.status).to be(404)
    end
  end

  context 'POST /api(/v:version)/friend_requests/accept' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should accept friend requests' do
      user.friend_requests.create(friend: friend)
      post :accept, params: { friend_id: friend.id }
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq('Friend request accepted successfuly.')
    end
  end

  context 'POST /api(/v:version)/friend_requests/decline' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should decline friend requests' do
      user.friend_requests.create(friend: friend)
      post :decline, params: { friend_id: friend.id }
      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq('Friend request declined successfuly.')
    end
  end
end
