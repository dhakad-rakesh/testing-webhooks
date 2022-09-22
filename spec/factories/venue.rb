FactoryBot.define do
  factory :venue do
    name { 'estadio atanasio girardot' }
    city_name { 'medellin' }
    country_name { 'colombia' }
    continent { 'south america' }
    country_code { 'COL' }

    before :create do |venue|
      venue.match_id = FactoryBot.create(:match).id
    end
  end
end
