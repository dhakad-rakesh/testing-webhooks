class Admin::SlotGamesController < Admin::BaseController
  def index
    @slot_games = fetch_slot_games
  end

  def update
    return render json: { message: status_message } if @slot_game.update(update_params)
    render json: { error: @slot_game.errors.full_messages.first }, status: :bad_request
  end

  private
  def update_params
    params.permit(:active, :is_featured)
  end

  def status_message
    if params[:active]
      status = @slot_game.active ? 'enabled' : 'disabled'
    else
      status = @slot_game.is_featured ? 'featured' : 'unfeatured'
    end
    t(".message_#{status}", name: @slot_game.name)
  end

  def fetch_slot_games
    slot_games = SlotGame.all
    slot_games = slot_games.search_by(params[:query]) if params[:query].present?
    slot_games.paginate(page: params[:page])
  end
end
