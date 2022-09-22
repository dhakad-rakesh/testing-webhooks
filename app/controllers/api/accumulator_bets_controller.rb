class Api::AccumulatorBetsController < Api::BaseController
  before_action :set_accumulator_bets, only: %I[index]
  before_action :set_betting_pool, only: %I[create index]

  def index
    render_collection(@accumulator_bets.paginate(page: params[:page], per_page: params[:per_page]))
  end

  def create
    status, failed_bets = AccumulatorBetCreate.new(user: current_user, bet_slips: params[:bet_slips],
                                                   betting_pool: @betting_pool).call
    return render_success_response(I18n.t('accumulator_bets.create.success')) if status
    render_error_response(failed_bets)
  end

  def batch_delete
    return render_error_response(I18n.t('accumulator_bets.invalid')) if params[:accumulator_bets].blank?
    begin
      current_user.accumulator_bets.hold
                  .where(id: params[:accumulator_bets]&.map { |accumulator_bet| accumulator_bet[:id] })&.destroy_all
      render_success_response(I18n.t('accumulator_bets.delete.success'))
    rescue ActiveRecord::InvalidForeignKey
      # If a bet has a ledger, it wont be deleted.
      render_error_response(I18n.t('accumulator_bets.delete.error'))
    end
  end

  def delete_bets
    return render_error_response(I18n.t('accumulator_bets.invalid')) if params[:accumulator_bets].blank?
    status, failed_bets = AccumulatorBetDelete.new(accumulator_bet_slips: params[:accumulator_bets],
                                                   user: current_user).call
    return render_success_response(I18n.t('accumulator_bets.update.success')) if status
    render_error_response(failed_bets)
  end

  def confirm
    status, _failed_bets = AccumulatorBets::Confirm.new(bets_params: params[:accumulator_bets], user: current_user).call
    return render_success_response(I18n.t('accumulator_bets.confirm.success')) if status

    render_error_response(I18n.t('accumulator_bets.confirm.failure'))
  end

  def cashout
    status, failed_bets = cashout_accumulator_bets
    return render_partial_success_response(I18n.t('accumulator_bets.cashout.failed'), failed_bets) unless status
    render_success_response(I18n.t('accumulator_bets.cashout.success'))
  end

  private

  def set_betting_pool
    return if params[:betting_pool_id].blank?
    @betting_pool = BettingPool.find_by(id: params[:betting_pool_id]&.to_i)
    return render_not_found_response(I18n.t('betting_pool.not_found')) unless @betting_pool
  end

  def cashout_accumulator_bets
    AccumulatorBets::Cashout.new(accumulator_bets: params[:accumulator_bets], user: current_user).call
  end

  def set_accumulator_bets
    params[:scope] = params[:scope].presence || 'all'
    @accumulator_bets = current_user.accumulator_bets.order(created_at: :desc)
    @accumulator_bets = @accumulator_bets.where(betting_pool: @betting_pool) if @betting_pool.present?
    return @accumulator_bets unless (scope_method =
                                       %w[pending won lost hold resolved].detect { |scope| params[:scope] == scope })
    @accumulator_bets = @accumulator_bets.send(scope_method)
  end
end
