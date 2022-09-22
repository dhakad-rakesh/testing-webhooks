FactoryBot.define do
  factory :security_answer do
    answer { 'abc' }
    user_id { FactoryBot.create(:user).id }
    security_question_id { FactoryBot.create(:security_question_1).id }
  end
end
