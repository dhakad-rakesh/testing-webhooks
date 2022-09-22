class Admin::TournamentsController < Admin::BaseController
  before_action :set_tournament, only: %I[show edit update change_status get_matches]
  before_action :set_sport, only: %I[index edit update]

  def index
    @tournaments = Tournament.sort_by_rank.includes(:sport)
    if params[:search].present?
      @tournaments = @tournaments.where("lower(name) ILIKE lower(?)", "%#{params[:search]}%")
    end
    if params[:sport_id].present?
      if @sport.blank?
        flash[:alert] = t('not_found', name: t('sport'))
      else
        @tournaments = @sport.tournaments
      end
    end
    
    @tournaments = @tournaments.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def show; end

  def edit; end

  def update 
    if @tournament.update(tournament_update_params)
      return redirect_to admin_sport_tournament_path(@sport, @tournament) if @sport.present?
      return redirect_to admin_tournaments_path
    else
      flash[:error] = t('went_wrong')
      #redirect_to admin_match_markets_path(@match)
    end
  end

  def change_status
    return render json: { error: t('not_found', name: t('tournament')) }, status: :not_found unless @tournament
    return render json: { message: tournament_status_message } if @tournament.update(update_params)
    render json: { error: @tournament.errors.full_messages.first }, status: :bad_request
  end

  def update_tournaments_rank
    params[:sorted_ids].each_with_index do |id, index|
      tournament = Tournament.find_by(id: id&.to_i)
      tournament.update(rank: index+1)
    end
    return render json: { message: "Rank updated successfully." }
  end

  def search
    @tournaments = Tournament.sort_by_rank.includes(:sport)
    @tournaments = @tournaments.where(sport_id: params[:sport_id]) if params[:sport_id].present?
    @tournaments = @tournaments.where(country_id: params[:country_id]) if params[:country_id].present?
    @tournaments = @tournaments.where(enabled: params[:enabled]) if params[:enabled].present?
    @tournaments = @tournaments.where("name ILIKE ?", "%#{params[:name].strip}%") if params[:name].present?
    @tournaments = @tournaments.paginate(page: params[:page], per_page: Constants::PER_PAGE)
    
    render :index
  end

  def get_matches
    return if params[:tournament_id].blank?
    
    render :json => @tournament.matches.pluck(:id, :name).presence || return
  end

  private

  def update_params
    params.permit(:enabled)
  end

  def tournament_update_params
    params.require(:tournament).permit(:display_name, :rank)
  end

  def set_tournament
    @tournament = Tournament.find_by(id: params[:tournament_id] || params[:id])
  end

  def set_sport
    @sport = Sport.find_by(id: params[:sport_id])
  end

  def tournament_status_message
    status = @tournament.enabled ? 'enabled' : 'disabled'

    t(".message_#{status}", name: @tournament.name)
  end
end
