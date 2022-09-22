class Admin::SportsController < Admin::BaseController
  before_action :set_sport, only: %w[update show get_tournaments]
  def index
    @sports = Sport.visible.order(:created_at)
  end

  def update
    return render json: { error: t('not_found', name: t('sport')) }, status: :not_found unless @sport
    return render json: { message: sport_status_message } if @sport.update(update_params)

    render json: { error: @sport.errors.full_messages.first }, status: :bad_request
  end

  def show; end

  def search
    @sports = Sport.visible.order(:created_at)
    @sports = @sports.where(kind: params[:kind]) if params[:kind].present?
    @sports = @sports.where(enabled: params[:enabled]) if params[:enabled].present?
    @sports = @sports.where("name ILIKE ?", "%#{params[:name].strip}%") if params[:name].present?
    respond_to do |format|
      format.js
    end
  end

  def update_sports_rank
    params[:sorted_ids].each_with_index do |id, index|
      sport = Sport.find_by(id: id&.to_i)
      sport.update(rank: index + 1)
    end

    render json: { message: 'Rank updated successfully.' }
  end

  def get_tournaments
    return if params[:sport_id].blank?

    render :json => @sport.tournaments.pluck(:id, :name).presence || return
  end

  private

  def update_params
    params.permit(:enabled, :rank)
  end

  def set_sport
    @sport = Sport.find_by(id: params[:sport_id] || params[:id])
  end

  def sport_status_message
    status = @sport.enabled ? 'enabled' : 'disabled'

    t(".message_#{status}", name: @sport.name)
  end
end
