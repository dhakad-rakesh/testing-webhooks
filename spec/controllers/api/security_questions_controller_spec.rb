require 'rails_helper'

describe Api::SecurityQuestionsController do
  context 'GET /api(/v:version)/security_questions' do
    it 'should return security_questions' do
      (1..2).each do |i|
        FactoryBot.create("security_question_#{i}".to_sym)
      end

      get :index

      result = JSON.parse(response.body)
      expect(response.status).to be(200)
      expect(result).to include('security_questions')
    end
  end
end
