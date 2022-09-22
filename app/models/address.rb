class Address < ApplicationRecord
  belongs_to :user

  validate :validate_country_name

  def to_s
    [street_address, zip_code, state, country].reject(&:blank?).join(', ')
  end

  def country_details
    ISO3166::Country.find_country_by_name(country)
  end

  def country_code
    country_details&.alpha2
  end

  def state_code
    country_details&.subdivision_names_with_codes.to_h[state]
  end

  def self.country_for_code(code)
    ISO3166::Country.find_country_by_country_code(code)
  end

protected
  
  def validate_country_name
    return if country_details
    errors.add(:address, 'Country is not valid')
  end
end
