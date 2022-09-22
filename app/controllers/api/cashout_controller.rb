class Api::CashoutController < Api::BaseController
  before_action :set_bet_data, only: [:create, :cashout_status]
  include Cashoutable::Base
  include Cashoutable::Single
  include Cashoutable::Combo

  def status
    bets = current_user.bets.pending.where(id: params[:bets]&.map { |bet| bet[:id] })
    return render_not_found_response(I18n.t('bets.not_found')) if bets.blank?
    render json: bets
  end

  def create
    if is_cashoutable?
      @status, @failed_bets = cashout_bets
    end

    if @status
      render_cashout_response(I18n.t('bets.cashout.success'), 200, nil)
    elsif @cashout_error
      render_cashout_response(I18n.t('bets.cashout.validation_failed'), 422, :cashout_error)
    elsif @cashoutable_mismatch_error
      render_cashout_response(I18n.t('bets.cashout.mistmatch_error'), 422, :cashoutable_mismatch_error, cashoutable: @cashoutable)
    else
      render_cashout_response((@failed_bets.flatten.first[:errors].reverse.join(", ") rescue ''), 422, :error)
    end 
  end
end
