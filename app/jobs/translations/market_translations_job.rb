module Translations
  class MarketTranslationsJob < ApplicationJob
    queue_as :low

    def perform(locale)
      params = { locale: locale.to_sym }
      FeedData::Driver.run!(action: action, mapper: mapper, params: params)
    end

  protected

    def action
      Translations::UpdateMarketJob
    end

    def mapper
      FeedData::Lsports::Mappers::Translations::Market
    end
  end
end
