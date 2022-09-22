class ComboBetNotifyMailer < ApplicationMailer
  before_action :set_parameters

  def won
    send_mail(@email, "Combo bet Won | Combo bet id #{@combo_bet.id}")
  end

  def lost
    send_mail(@email, "Combo bet Lost | Combo bet id #{@combo_bet.id}")
  end

  def placed
    send_mail(@email, "Combo bet Placed | Combo bet id #{@combo_bet.id}")
  end

  def refunded
    send_mail(@email, "Combo bet Refunded | Combo bet id #{@combo_bet.id}")
  end

  private

  def set_parameters
    @combo_bet = ComboBet.find_by(id: params[:combo_bet_id])
    @email = @combo_bet.user.email
    @bets = @combo_bet.bets
    @total_winning_amount = @combo_bet.to_win
  end
end