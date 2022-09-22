FactoryBot.define do
  factory :match do
    status          { 'not_started' }
    booking_status  { 'booked' }
    actual_status   { '0' }
    enabled         { true }
    sequence(:uid) { |n| "2#{n}" }

    before :create do |match|
      sport_id = FactoryBot.create(:sport).id
      tournament_id = FactoryBot.create(:tournament, :with_teams, sport_id: sport_id).id
      match.sport_id = sport_id
      match.tournament_id = tournament_id
    end

    after :create do |match|
      FactoryBot.create(:soccer_match_score, match_id: match.id)
    end
  end
end
