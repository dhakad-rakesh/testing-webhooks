module Translations
  class UpdateMarketJob < ApplicationJob
    queue_as :low

    def perform(data:, locale: 'en')
      Translations::UpdateMarket.run!(data: data, locale: locale.to_sym)
    end
  end
end

