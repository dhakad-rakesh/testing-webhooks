FactoryBot.define do
  factory :market do
    name { 'Total' }
    sequence(:uid) { |n| "23#{n}" }
  end
end
