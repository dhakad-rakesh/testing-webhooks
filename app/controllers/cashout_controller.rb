class CashoutController < ApplicationController
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

    respond_to do |format|
      format.js
    end
  end
end
