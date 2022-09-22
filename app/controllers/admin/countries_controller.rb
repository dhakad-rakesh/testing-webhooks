class Admin::CountriesController < Admin::BaseController
  # before_action :set_sport_country, only: %I[change_status]
  before_action :set_sport, only: :index

  def index
    @sport_countries = @sport.sport_countries.sorted_by_rank
  end

  # def change_status
  #   return render json: { error: t('not_found', name: t('sport_country')) }, status: :not_found unless @sport_country
  #   # return render json: { message: country_status_message } if @country.update(update_params)
  #   render json: { error: @country.errors.full_messages.first }, status: :bad_request
  # end

  def update_countries_rank
    params[:sorted_ids].each_with_index do |id, index|
      sport_country = SportCountry.find_by(id: id&.to_i)
      sport_country.update(rank: index+1)
    end
    return render json: { message: "Rank updated successfully." }
  end

  private

  # def update_params
  #   params.permit(:enabled)
  # end

  def set_sport_country
    @sport_country = SportCountry.find_by(id: params[:id])
  end

  def country_status_message
    status = @country.enabled ? 'enabled' : 'disabled'

    t(".message_#{status}", name: @country.name)
  end

  def set_sport
    @sport = if params[:query].blank?
      Sport.find_by_name('Football') 
    else
      Sport.find_by_id(params.dig(:query, :sport_id)) 
    end
  end

end
