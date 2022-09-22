module Api
  module Countries
    extend ActiveSupport::Concern
    def fetch_countries
      return params[:country] if params[:country].present?
      return if params[:continent].blank?
      countries_by_continent
    end

    def countries_by_continent
      Venue.where(continent: params[:continent].downcase).pluck(:country_name).uniq
    end
  end
end
