FactoryBot.define do
  factory :bet do
    bet_type { 'traditional' }
    status { 'pending' }
    stake { 200.0 }
    odds { '2.5' }
  end
end
