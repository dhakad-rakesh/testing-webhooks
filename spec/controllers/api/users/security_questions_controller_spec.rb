require 'rails_helper'

describe Api::Users::SecurityQuestionsController do
  let!(:user) { FactoryBot.create(:user, :with_security_answers) }
  let!(:token) { user.generate_access_token.token }
  let!(:security_answer) { user.security_answers.sample }

  context 'GET /api(/v:version)/users/security_questions' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
    end

    it 'should return user\'s security_questions' do
      get :index, params: { email: user.email }

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('security_questions')
    end
  end

  context 'POST /api(/v:version)/users/security_questions/:security_question_id/verify' do
    it 'should not verify security answer when user not exist' do
      post :verify, params: {
        security_question_id: security_answer.security_question_id,
        answer: security_answer.answer
      }

      result = JSON.parse(response.body)
      expect(result['message']).to eq('User not found')
      expect(response.status).to be(404)
    end

    it 'should verify security answer with valid params' do
      post :verify, params: {
        email: user.email,
        security_question_id: security_answer.security_question_id,
        answer: security_answer.answer
      }

      result = JSON.parse(response.body)
      expect(result['result']).to be_truthy
      expect(response.status).to be(200)
    end

    it 'should not verify security answer when answer is invalid' do
      post :verify, params: {
        email: user.email,
        security_question_id: security_answer.security_question_id,
        answer: 'xyz'
      }

      result = JSON.parse(response.body)
      expect(result['result']).to be_falsey
      expect(response.status).to be(400)
    end

    it 'should not verify security answer when security_question is invalid' do
      post :verify, params: {
        email: user.email,
        security_question_id: 'xyz',
        answer: security_answer.answer
      }

      result = JSON.parse(response.body)
      expect(result['result']).to be_falsey
      expect(response.status).to be(400)
    end
  end
end
