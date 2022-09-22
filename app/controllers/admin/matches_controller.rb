class Admin::MatchesController < Admin::BaseController
  before_action :set_match, only: %I[update change_market_status show get_markets update_match_details]
  before_action :assign_matches, only: %I[index search]

  def index
    @matches = @matches.schedulable.paginate(page: params[:page], per_page: Constants::PER_PAGE)

    @matches = @matches.where(tournament_id: params[:tournament_id]) if params[:tournament_id].present?
  end

  def show; end

  def update
    return render json: { error: t('not_found', name: t('match')) }, status: :not_found unless @match
    return render json: { message: match_status_message } if @match.update(update_params)
    render json: { error: @match.errors.full_messages.first }, status: :bad_request
  end

  def change_market_status
    return render json: { error: t('not_found', name: t('match')) }, status: :not_found unless @match
    market_id = update_params[:market_id].to_i
    inactive_ids = @match.inactive_market_ids
    update_params[:enabled] == 'true' ? inactive_ids.delete(market_id) : inactive_ids.push(market_id)
    return render json: { message: market_status_message } if @match&.update(inactive_market_ids: inactive_ids)
    render json: { error: @match.errors.full_messages.first }, status: :bad_request
  end

  def search
    @matches = Match.all
    @matches = @matches.where(sport_id: params[:sport_id]) if params[:sport_id].present?
    @matches = @matches.where(tournament_id: params[:tournament]) if params[:tournament].present?
    # @matches = @matches.where(highlight: params[:highlight] == 'false' ? [nil, false] : true ) if params[:highlight] != 'all'
    @matches = @matches.where(enabled: params[:enabled]) if params[:enabled] != 'all'
    @matches = @matches.where('name ilike ?', "%#{params[:participants].strip}%") if params[:participants].present?
    if params[:match_status].present?
      if params[:match_status].eql?("live")
        @is_live_filter = true
        @matches = @matches.where(status: "in_progress", inplay_subscribed: true)
      else
        @matches = @matches.where(status: params[:match_status])
      end
    end
    @matches = @matches.paginate(page: params[:page], per_page: Constants::PER_PAGE)
    # return render :index if params[:page].present?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def get_markets
    return if @match.blank?
    @markets = @match.sport.markets

    render :json => @markets
  end

  def fetch_tournaments
    sport = Sport.find_by(id: params[:sport_id])
    @tournaments = sport.tournaments.order(:rank) 
    render :json => @tournaments
  end

  def update_match_details
    if @match.update(match_detail_params)
      render js: "toastr.success('Details updated')" 
    else
      render js: "toastr.error(#{@match.errors.full_messages.join('<br/>')})"
    end
  end

  private

  def update_params
    params.permit(:visible, :market_id, :id, :highlight)
  end

  def match_detail_params
    params.require(:match).permit(:streaming_url)
  end

  def set_match
    @match = Match.find_by(id: params[:id])
  end

  def assign_matches
    if params[:tournament_id].present?
      @tournament = Tournament.find_by(id: params[:tournament_id].to_i)
      @matches = @tournament.matches.select(
        :id, :schedule_at, :sport_id, :settings, :visible, :status, :tournament_id, :highlight, :uid
      )
    else
      @matches = Match.all.select(
        :id, :schedule_at, :sport_id, :settings, :visible, :status, :tournament_id, :highlight, :uid
      )
    end
  end

  def match_status_message
    if params[:highlight].blank?
      status = @match.enabled ? 'enabled' : 'disabled'
    else
      status = @match.highlight ? 'highlighted' : 'unhighlighted'
    end

    t(".match_#{status}", uid: @match.uid)
  end

  def market_status_message
    status = update_params[:enabled] == 'true' ? 'enabled' : 'disabled'
    
    t(".market_#{status}", uid: @match.uid)
  end
end
