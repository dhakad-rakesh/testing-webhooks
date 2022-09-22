require 'rails_helper'

describe Api::FriendsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:friend) { FactoryBot.create(:user, username: 'abc888', email: 'abc888@example.com', password: 'Gammabet@123') }

  context 'GET /api(/v:version)/friends' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return friends' do
      user.friend_requests.create(friend: friend).accept
      get :index

      result = JSON.parse(response.body)
      expect(result['users'].present?).to be(true)
      expect(response.status).to be(200)
    end
  end

  context 'DELETE /api(/v:version)/friends/:id' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should delete a friend' do
      confirm_friend = user.friend_requests.create(friend: friend)
      confirm_friend.accept
      delete :destroy, params: { id: friend.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Successfully removed friend.')
      expect(response.status).to be(200)
    end

    it 'should not able to delete a deleted friend' do
      confirm_friend = user.friend_requests.create(friend: friend)
      confirm_friend.accept
      user.friends.destroy_all
      delete :destroy, params: { id: friend.id }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Friend not found.')
      expect(response.status).to be(404)
    end
  end
end
