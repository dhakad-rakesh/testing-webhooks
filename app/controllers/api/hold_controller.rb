class Api::HoldController < Api::BaseController
  before_action :bet, only: %I[current_odds]
  before_action :set_betting_pool, only: %I[create]

  def create
    status, _failed_bets = HoldBet.new(bet_slips: params[:bet_slips], user: current_user,
                                       betting_pool: @betting_pool).call
    return render_success_response(I18n.t('bets.create.success')) if status

    render_error_response(I18n.t('hold.create.failure'))
  end

  def confirm
    status, _failed_bets = ConfirmHoldBet.new(bets_params: params[:bets], user: current_user).call
    return render_success_response(I18n.t('hold.confirm.success')) if status
    render_error_response(I18n.t('hold.confirm.failure'))
  end

  def batch_delete
    return render_error_response(I18n.t('hold.invalid')) if params[:bets].blank?
    begin
      current_user.bets.hold.where(id: params[:bets]&.map { |bet_id| bet_id[:id] })&.destroy_all
      render_success_response(I18n.t('hold.delete.success'))
    rescue ActiveRecord::InvalidForeignKey
      # If a bet has a ledger, it wont be deleted.
      render_error_response(I18n.t('hold.delete.error'))
    end
  end

  def current_odds
    return render_error_response(I18n.t('hold.invalid')) if @bet.blank?
    odds = @bet.current_odds
    return render_error_response(I18n.t('hold.odds.not_found')) if odds.blank?
    render json: { odds: odds }
  end

  private

  def set_betting_pool
    return if params[:betting_pool_id].blank?
    @betting_pool = BettingPool.find_by(id: params[:betting_pool_id]&.to_i)
    return render_not_found_response(I18n.t('betting_pool.not_found')) unless @betting_pool
  end

  def fetch_market_data(bet)
    @data = OddStore.new(bet.match_id).odds_data
    @data.dig(:markets, bet.market_id, bet.identifier) if @data.present?
  end

  def fetch_market_data_with_specifier(bet)
    @data.dig(:markets, bet.market_id).select do |_identifier, value|
      value[:specifier] == bet.specifier_text
    end
  end

  def bet
    @bet ||= Bet.find_by(id: params[:id]&.to_i)
  end
end
