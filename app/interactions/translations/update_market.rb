module Translations
  class UpdateMarket < ApplicationInteraction
    hash :data, strip: false
    symbol :locale

    set_callback :execute, :before, :market

    def execute
      return unless market
      Mobility.with_locale(locale) do
        market.update(name: data['name'])
      end
    end

  protected

    def market
      @market ||= ::Market.find_by(uid: data['uid'])
    end
  end
end
