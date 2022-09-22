namespace :translations do
  desc "Migrate data from existing to translated columns"
  task migrate_data: :environment do
    Constants::TRANSLATED_MODELS.each do |model|
      MigrateTranslatedColumnsData.run!(model: model, column: 'name', locale: :en)
    end
  end
end
