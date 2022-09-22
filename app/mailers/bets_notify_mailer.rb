class BetsNotifyMailer < ApplicationMailer
  before_action :set_parameters, except: [:cashed_out_combo_bet]

  def placed
    send_mail(@email, "Bet Placed | #{@match_title}")
  end

  def won
    calculate_winning_amount
    send_mail(@email, "Bet Won | #{@match_title}")
  end

  def half_won
    calculate_winning_amount(true)
    send_mail(@email, "Bet Half Won | #{@match_title}")
  end

  def lost
    send_mail(@email, "Bet Lost | #{@match_title}")
  end

  def half_lost
    calculate_winning_amount(true)
    send_mail(@email, "Bet Half Won | #{@match_title}")
  end

  def cashed_out
    send_mail(@email, "Bet Cashed Out | #{@match_title}")
  end

  def refunded
    send_mail(@email, "Bet Refunded | #{@match_title}")
  end

  def held
    send_mail(@email, "Bet Held | #{@match_title}")
  end

  def cashed_out_combo_bet
    @combo = ComboBet.find_by(id: params[:combo_id])
    @email = @combo.user.email
    send_mail(@email, "Combo Bet Cashed Out")
  end

  private

  def set_parameters
    @bet = Bet.find_by(id: params[:bet_id])
    @email = @bet.user.email
    @match_title = @bet.match.title
  end

  def calculate_winning_amount(half = false)
    @winning_amount = unless half
                        @bet.total.to_f.round(8)
                      else
                        (@bet.total.to_f/2).round(8)
                      end
  end
end
