FactoryBot.define do
  factory :outcome do
    name { '{$competitor1}' }
    sequence(:uid) { |n| "231#{n}" }
  end
end
