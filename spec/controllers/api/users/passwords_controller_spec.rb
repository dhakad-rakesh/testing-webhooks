require 'rails_helper'

describe Api::Users::PasswordsController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }

  context 'GET /api(/v:version)/users/passwords/new' do
    it 'should sent reset password instrucation' do
      get :new, params: {
        email: user.email
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq("Reset password instructions have been sent to #{user.email}.")
    end
  end

  context 'PATCH /api(/v:version)/users/passwords ' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should update the password' do
      patch :update, params: {
        current_password: 'Gammabet@123',
        password: 'Tester@123',
        password_confirmation: 'Tester@123'
      }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('Password updated successfully.')
      expect(response.status).to be(200)
    end

    it 'should not update password when current password is not passed' do
      patch :update, params: {
        password: 'Tester@123',
        password_confirmation: 'Tester@123'
      }

      result = JSON.parse(response.body)
      expect(result['message'].first).to eq('Current password can\'t be blank')
      expect(response.status).to be(400)
    end
  end

  context 'POST /api(/v:version)/users/passwords' do
    it 'should set forgot password when user exist' do
      post :create, params: {
        email: user.email
      }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('New password is sent to your email')
      expect(response.status).to be(200)
    end

    it 'should not set forgot password when user is not exist' do
      post :create, params: {
        email: 'tester@yopmail.com'
      }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('User not found')
      expect(response.status).to be(404)
    end
  end
end
