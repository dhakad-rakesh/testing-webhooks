class Venue < ApplicationRecord
  belongs_to :match
  before_create :set_continent
  before_save :set_continent, unless: :continent?

  def set_continent
    self.continent = if Constants::UK_COUNTRY_CODES.keys.map(&:to_s).include?(country_code)
                       'europe'
                     else
                       ISO3166::Country.find_country_by_alpha3(country_code)&.continent&.downcase
                     end
  end
end
