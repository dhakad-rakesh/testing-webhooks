class Admin::QTechFreeRoundsController < Admin::BaseController

  def index
    @rounds = QTechFreeRound.order_by_recent.paginate(page: params[:page])
  end

  def new
    @round = QTechFreeRound.new
  end

  def create
    txn_ids = QTechFreeRound.pluck(:txn_id)
    begin
      txn_id = SecureRandom.hex(12).to_s
      id_exist = txn_ids.include?(txn_id)
    end while id_exist
    r_params = generate_r_params(txn_id)
    result = client.create_round(r_params)
    @round = QTechFreeRound.new(q_tech_free_round_params.merge(txn_id: result['txnId'], bonus_id: result['bonusId']))
    if @round.save
      flash[:notice] = t('success_create', name: t('round'))
      redirect_to admin_q_tech_free_rounds_path
    else
      flash[:error] = @round.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def destroy
    @round = QTechFreeRound.where(id: params[:id]).first
    if @round.present?
      result = client.delete_round_promotion(@round.bonus_id, @round.user_id)
      @round.destroy
      flash[:notice] = t('success_destroy', name: t('round'))
    else
      flash[:error] = @round.errors.full_messages.join('<br/>')
    end
    redirect_to admin_q_tech_free_rounds_path
  end

  def generate_r_params(txn_id)
    uid = QTechCasinoGame.find(params[:q_tech_free_round][:q_tech_casino_game_id]).uid
    {
      "txnId": txn_id,
      "playerId": params[:q_tech_free_round][:user_id].to_s,
      "gameId": uid,
      "totalBetValue": params[:q_tech_free_round][:total_bet_value].to_f,
      "currency": params[:q_tech_free_round][:currency].to_s,
      "validityDays": params[:q_tech_free_round][:validity_days]
    }
  end

  private

  def client
    @client ||= Qtech::ApiClient::Client.new
  end

  def q_tech_free_round_params
    params.require(:q_tech_free_round).permit(
      :txn_id, :user_id, :q_tech_casino_game_id, :total_bet_value,
      :total_payout, :round_options, :currency, :promo_code, :validity_days,
      :rejectable, :bonus_id, :status, :promoted_date_time, :claimed_date_time,
      :failed_date_time, :completed_date_time, :cancelled_date_time, :deleted_date_time,
      :expired_date_time, :claimed_round_option
    )
  end

end
