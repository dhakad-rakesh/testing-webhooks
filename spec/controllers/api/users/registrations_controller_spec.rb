require 'rails_helper'

describe Api::Users::RegistrationsController do
  let!(:user) { FactoryBot.build(:user) }
  let!(:security_question_1) { FactoryBot.create(:security_question_1) }
  let!(:security_question_2) { FactoryBot.create(:security_question_1) }
  context 'POST /api(/v:version)/users' do
    it 'should signup a user with valid params' do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        username: user.username,
        password: user.password,
        security_answers: [{ question_id: security_question_1, answer: 'abc' }]
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result['message']).to eq('Conformation email is sent to your email')
    end

    it 'should not signup a user without password' do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        username: user.username,
        security_answers: [{ question_id: security_question_1, answer: 'abc' }]
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to include('Password is required')
    end

    it 'should not signup a user without username' do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password,
        security_answers: [{ question_id: security_question_1, answer: 'abc' }]
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to include('Username is required')
    end

    it 'should not signup a user without email' do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        password: user.password,
        username: user.username,
        security_answers: [{ question_id: security_question_1, answer: 'abc' }]
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to include('Email is required')
    end

    it 'should not signup a user without security_answers' do
      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password,
        username: user.username
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to include('Security answers is required')
    end

    it 'should not signup a user with existing email or username' do
      FactoryBot.create(:user)

      post :create, params: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password,
        username: user.username,
        security_answers: [{ question_id: security_question_1, answer: 'abc' }]
      }

      result = JSON.parse(response.body)
      expect(response.status).to be(400)
      expect(result['message']).to include('Email has already been taken', 'Username has already been taken')
    end
  end
end
