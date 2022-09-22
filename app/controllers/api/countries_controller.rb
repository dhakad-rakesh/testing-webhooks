require 'will_paginate/array'

class Api::CountriesController < Api::SkipAuthenticationController
  def index
    countries = {}
    countries[:countries] = []
    SportCountry.includes(country: :tournaments).filter_by_sport(params[:sport_id]).enabled.with_matches.sorted_by_rank.each do |sport_country|
      # sport_country = sport_country(country.id)
      # next if sport_country.blank?
      country = sport_country.country
      number_of_matches = sport_country.number_of_matches
      next if number_of_matches.zero?
      serialized_country = CountrySerializer.new(country, 
        number_of_matches: number_of_matches,
        sport_id: sport_country.sport_id,
        scope: current_user,
        scope_name: :current_user
      )
      countries[:countries] << serialized_country
    end
    paginated_countries = countries[:countries].paginate(page: params[:page], per_page: params[:per_page])
    render json: {
      countries: paginated_countries,
      meta: pagination_dict(paginated_countries)
    }
  end

  # TODO : Update code here
  def cities
    cities = CS.cities(params[:id], :GB)
    if cities.blank?
      country = ISO3166::Country.find_country_by_alpha3(params[:id])
      cities = country_cites(country)
      return(render json: { message: I18n.t(:invalid_country) }) if cities.blank?
    end
    render json: cities
  end

  def registration_countries
    enabled_countries = GammabetSetting.registration_enabled_countries
    countries = ISO3166::Country.countries
    # By default enable all countries
    if enabled_countries.present?
      countries = countries.select { |country| enabled_countries.include?(country.alpha3) }
    end
    render json: format_countries(countries), adapter: nil
  end

  private

  def country_cites(country)
    return if country.blank?
    alpha2 = country.alpha2.downcase
    CS.states(alpha2).keys.flat_map { |state| CS.cities(state, alpha2) }.sort
  end

  def sport_country(country_id)
    SportCountry.find_by(sport_id: params[:sport_id], country_id: country_id)
  end

  def format_countries(countries)
    countries = countries.map { |country| country.data.slice(*Constants::REGISTRATION_COUNTRY_FIELDS) }
    countries.sort_by { |country| [rank(country), country['name']] }
  end

  def rank(country)
    @top_countries ||= GammabetSetting.top_countries
    @top_countries.include?(country['alpha3']) ? 0 : 1
  end
end
