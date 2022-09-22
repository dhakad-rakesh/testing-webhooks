namespace :categories do
  task generate_translations: :environment do
    Constants::LSPORTS_LANGUAGE_MAP.keys do |locale|
      GenerateCategoryTranslations.run!(locale: locale)
    end
  end
end