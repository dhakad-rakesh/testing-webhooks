module Cashoutable
  module Single
    def single_cashout(bet)
      { odds: single_bet_odds(bet), amount: single_bet_amount(bet) }
    end

    def single_bet_odds(bet)
      bet.current_odds.to_f
    end

    def single_bet_amount(bet)
      CashoutService.payout_value(bet, single_bet_odds(bet))
    end
  end
end