FactoryBot.define do
  factory :user do
    username { 'abc999' }
    email { 'abc999@example.com' }
    password { 'Gammabet@123' }
  end

  trait :with_security_answers do
    after :create do |user|
      security_question1 = FactoryBot.create(:security_question_1)
      security_question2 = FactoryBot.create(:security_question_2)
      FactoryBot.create(:security_answer,
        user_id: user.id,
        security_question_id: security_question1.id,
        answer: 'abc')
      FactoryBot.create(:security_answer,
        user_id: user.id,
        security_question_id: security_question2.id,
        answer: 'abc')
    end
  end
end
