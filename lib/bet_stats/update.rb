module BetStats
  class Update
    attr_accessor :source

    def initialize(bet:)
      @source = bet
    end

    def call
      source_combo? ? update_combo_bet : update_single_bet
    end

    def update_bonus_stake
      source_combo? ? update_combo_bonus_stake : update_single_bonus_stake
    end

    private

    attr_accessor :total_winning_amount, :total_odds, :total_stake, :total_profit, :total_bonus_amount

    def source_combo?
      source.class.name.eql?("ComboBet")
    end

    def update_single_bet
      source.assign_attributes(
        winnings: source.winning_amount,
        profit: single_profit
      )
    end

    def update_single_bonus_stake
      source.assign_attributes(bonus_stake: bonus_amount)
    end

    def available_bonus
      @available_bonus ||= source.user.current_wallet.bonus
    end
  
    def bonus_amount
      (source.stake <= available_bonus) ? source.stake : available_bonus
    end

    def update_combo_bonus_stake
      @total_bonus_amount = source.bonus_stake
      @total_odds = source.bets.sum('CAST(odds as decimal)')
      @total_stake = source.stake

      source.bets.each { |bet| update_combo_single_bonus_stake(bet: bet) }
    end

    def update_combo_single_bonus_stake(bet:)
      bet.update!(
        stake: stake_amount(bet: bet),
        bonus_stake: combo_bonus_amount(bet: bet)
      )
    end

    def single_profit
      source.stake - source.winning_amount - source.cashed_out_amount.to_f
    end

    def update_combo_bet
      @total_stake = source.stake
      @total_winning_amount = source.winning_amount
      @total_odds = source.bets.sum('CAST(odds as decimal)')
      @total_profit = total_stake - total_winning_amount - source.cashout_amount.to_f
      
      Bet.transaction do
        source.bets.each { |bet| update_combo_single(bet: bet) }
      end
    end

    def update_combo_single(bet:)
      bet.update!(
        winnings: winning_amount(bet: bet),
        profit: combo_single_profit(bet: bet)
      )
    end

    def combo_bonus_amount(bet:)
      separator(bet: bet) * total_bonus_amount
    end

    def combo_single_profit(bet:)
      separator(bet: bet) * total_profit
    end

    def winning_amount(bet:)
      separator(bet: bet) * total_winning_amount
    end

    def stake_amount(bet:)
      separator(bet: bet) * total_stake
    end

    def separator(bet:)
      bet.odds.to_f / total_odds
    end
  end
end
