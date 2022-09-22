class GenerateCategoryTranslations < ApplicationInteraction
  symbol :locale

  def execute
    categories.each do |category|
      Mobility.with_locale(locale) do
        category.update(name: translated_name(category.name))
      end
    end
  end

private

  def categories
    Category.all
  end

  # TODO: Map with custom id
  def translated_name(name)
    ::Market::CATEGORY_NAMES_MAP.dig(name, locale)
  end
end

