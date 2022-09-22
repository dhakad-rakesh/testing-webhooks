module Betradar
  class Client < Request
    attr_accessor :api_key, :base_url
    include Api::OddsRecover
    include Api::StaticSportEventInformation
    include Api::SportEventInformation
    include Api::BettingDescriptions
    include Api::Probability
    include Api::EntityDescriptions
    include Api::BookingCalendar

    def initialize
      @api_key = Figaro.env.betradar_api_key
      @base_url = Figaro.env.betradar_base_url
    end

    private

    def request_url(path)
      "#{base_url}/#{path}"
    end

    def headers
      { "x-access-token": api_key }
    end
  end
end
