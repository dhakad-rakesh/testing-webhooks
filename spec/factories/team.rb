FactoryBot.define do
  factory :team do
    name { 'Club Calor' }
    country_name { 'Mexico' }
    acronym { 'CLU ' }
    sequence(:uid) { |n| "sr:competitor#{n}" }
    sport_id { FactoryBot.create(:sport).id }
  end
end
