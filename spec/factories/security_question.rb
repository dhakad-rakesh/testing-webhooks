FactoryBot.define do
  factory :security_question_1, class: 'SecurityQuestion' do
    question { 'What is your first pet name?' }
    enabled  { true }
  end

  factory :security_question_2, class: 'SecurityQuestion' do
    question { 'What is your father\'s name?' }
    enabled  { true }
  end
end
