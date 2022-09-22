FactoryBot.define do
  factory :topic do
    name { (0..8).map { rand(65..90).chr }.join }
    enabled { false }
  end
end
