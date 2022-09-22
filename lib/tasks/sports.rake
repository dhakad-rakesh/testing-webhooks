
namespace :sports do
  desc "Create esports from LSports"
  task create: :environment do
    Lsports::Sports.create
  end

  desc "Fetch and generate translations from Feed provider"
  task generate_translations: :environment do
    Constants::LSPORTS_LANGUAGE_MAP.keys do |locale|
      params = { locale: locale }
      FeedData::Driver.run!(
        action: Translations::UpdateSport,
        mapper: FeedData::Lsports::Mappers::Translations::Sport, 
        params: params,
        async: false
      )
    end
  end
end
