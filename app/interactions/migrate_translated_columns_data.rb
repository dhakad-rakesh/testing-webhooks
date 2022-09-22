class MigrateTranslatedColumnsData < ApplicationInteraction
  string :model
  string :column
  symbol :locale, default: :en

  def execute
    Mobility.with_locale(locale) do
      ActiveRecord::Base.transaction do
        model.constantize.find_each do |record|
          next unless record.read_attribute(column).present?
          record.update!(name: record.read_attribute(column))
        end
      end
    end
  end
end

