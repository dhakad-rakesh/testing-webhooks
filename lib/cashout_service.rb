module CashoutService
  class << self
    def cashout_value(bet, cashout_odds)
      # ((initial bet odds / current in-play odds) x initial bet stake)
      amount = ((bet.odds.to_f / cashout_odds.to_f) * bet.stake)
      return amount.round(6)
    end

    def payout_value(bet, cashout_odds)
      # cashout_value * (x% of Cashout Value)
      cashout_value = cashout_value(bet, cashout_odds)
      commision_amt = (cashout_value * GammabetSetting.cashout_commision) / 100
      return (cashout_value - commision_amt).round(6)
    end
  end
end