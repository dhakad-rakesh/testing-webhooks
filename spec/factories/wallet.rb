FactoryBot.define do
  factory :wallet do
    association :user
    available_amount { 1000 }
  end
end
