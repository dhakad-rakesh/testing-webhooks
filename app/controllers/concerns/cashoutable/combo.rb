module Cashoutable
  module Combo
    def combo_cashout(combo)
      { odds: combo_bet_odds(combo.bets), amount: combo_bet_amount(combo) }
    end

    def combo_bet_odds(bets)
      c_odds = bets.map{|b| b.current_odds.to_f }
      NumberService.round_to_2_decimal(c_odds.reject(&:zero?).inject(:*))
    end

    def combo_bet_amount(combo)
      CashoutService.payout_value(combo, combo_bet_odds(combo.bets))
    end
  end
end