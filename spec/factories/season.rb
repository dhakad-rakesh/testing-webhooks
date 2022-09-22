FactoryBot.define do
  factory :season do
    name { 'Primera Division 18/19' }
    sequence(:uid) { |n| "sr:season#{n}" }
    start_time { Time.zone.now }
    end_time { Time.zone.now + 6.months }
    before :create do |season|
      tournament = FactoryBot.create(:tournament)
      season.tournament_id = tournament.id
      season.sport_id = tournament.sport.id
    end
  end
end
