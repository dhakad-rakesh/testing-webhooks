class Api::PreferencesController < Api::BaseController
  # skip_before_action :check_country_status
  skip_before_action :user_authorize!, only: :index

  def index
    render json:
    {
      languages: Language.select(:id, :name).order(:name),
      dialect: Dialect.select(:id, :name).order(:name),
      countries: (
        ISO3166::Country.all.map { |a| { name: a.name, id: a.alpha3 } } +
        [
          Constants::UK_COUNTRY_CODES.map { |k, v| { name: v.titleize, id: k.to_s } }
        ]
      ).flatten.sort_by { |a| a[:name] },
      odds_formats: Constants::ODDS_FORMATE
    }
  end
end
