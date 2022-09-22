class Api::ParticipantsController < Api::BaseController
  before_action :set_betting_pool, only: %I[index]

  def index
    participants = @betting_pool.participants.includes(:user, :wallet)
                                .order('wallets.available_amount DESC')
                                .paginate(page: params[:page], per_page: params[:per_page])
    render json: participants
  end

  def create
    participant = PoolBetting::Enter.run(params.permit(:betting_pool_id).merge(user_id: current_user.id))
    if participant.errors.blank?
      render_success_response(I18n.t('betting_pool.enter.success'))
    else
      render_error_response(participant.errors.full_messages.to_sentence)
    end
  end

  private

  def set_betting_pool
    @betting_pool = BettingPool.find_by(id: params[:betting_pool_id].to_i)
    return render_error_response(I18n.t('betting_pool.not_found')) if @betting_pool.blank?
  end
end
