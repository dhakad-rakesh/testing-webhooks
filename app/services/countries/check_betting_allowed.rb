module Countries
  class CheckBettingAllowed
    def initialize(args = {})
      @country_code = Rails.cache.fetch(args[:ip_address]) do
        Geocoder.search(args[:ip_address]).first.try(:country_code)
      end
    end

    def call
      Constants::ALLOWED_COUNTRY_CODES.include?(@country_code)
    end
  end
end
