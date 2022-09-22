FactoryBot.define do
  factory :sport do
    name { 'Soccer' }
    status { 'active' }
    sequence(:uid) { |n| "1#{n}" }
  end
end
