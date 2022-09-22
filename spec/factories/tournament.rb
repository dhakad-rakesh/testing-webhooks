FactoryBot.define do
  factory :tournament do
    name { 'Liga Profesional Bolivia' }
    enabled { true }
    tournament_type { 'tournament' }
    sequence(:uid) { |n| "sr:simple_tournament#{n}" }
    trait :league do
      tournament_type { 'league' }
    end

    trait :cup do
      tournament_type { 'cup' }
    end

    before :create do |tournament|
      tournament.sport_id = FactoryBot.create(:sport).id
    end

    trait :with_teams do
      after :create do |tournament|
        tournament.teams << FactoryBot.create(:team, sport_id: tournament.sport_id)
      end
    end
  end
end
