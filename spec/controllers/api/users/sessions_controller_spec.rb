require 'rails_helper'

describe Api::Users::SessionsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }

  context 'POST /users/sign_in' do
    it 'should sign_in the user with email' do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      post :create, params: { login: user.email, password: 'Gammabet@123' }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('access_token', 'user')
    end

    it 'should sign_in the user with username' do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      post :create, params: { login: user.username, password: 'Gammabet@123' }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('access_token', 'user')
    end

    it 'should not sign_in the user without password' do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      post :create, params: { login: user.username }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to eq('invalid password')
    end

    it 'should not sign_in the user when user not exist' do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      post :create, params: { login: 'tester' }

      result = JSON.parse(response.body)
      expect(response.status).to be(404)
      expect(result['message']).to eq('User not found')
    end
  end

  context '/api(/v:version)/users/sign_out' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should sign_out the user' do
      delete :destroy

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq('Successfully sign out')
    end

    it 'should not sign_out the user without invalid token' do
      token = '11111'
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"

      delete :destroy
      expect(response.status).to be(401)
    end
  end
end
