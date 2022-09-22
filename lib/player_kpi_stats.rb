class PlayerKpiStats
  def initialize(user:)
    @user = user
  end

  def stats
    @stats ||= OpenStruct.new(
      betting: betting,
      finance: finance
    )
  end

  private

  attr_accessor :user

  def betting
    OpenStruct.new(
      last_bet: last_bet,
      total_stakes: total_stakes,
      winnings: winnings,
      unsettled_stakes: unsettled_stakes,
      pl: pl.abs,
      profitability: profitability,
      total_bets: total_bets,
      total_unsettled_bets: total_unsettled_bets
    )
  end

  def finance
    OpenStruct.new(
      total_deposits_amount: user_ledgers.deposits.sum(:amount),
      total_withdrawals_amount: user_withdrawals.pluck(:amount).sum(&:abs),
      withdrawals_count: user_withdrawals.count,
      last_withdrawals_date: user_withdrawals.last&.created_at
    )
  end

  def user_ledgers
    @user_ledgers ||= user.ledgers
  end

  def user_withdrawals
    @user_withdrawals ||= user_ledgers.withdrawals
  end

  def last_bet
    user.bets.last&.created_at
  end

  def total_stakes
    bets.sum(:stake) + combo_bets.sum(:stake)
  end

  def total_bets
    bets.count + combo_bets.count
  end

  def total_unsettled_bets
    pending_bets.count + pending_combo_bets.count
  end

  def winnings
    bets.total_winnings + combo_bets.total_winnings
  end

  def unsettled_stakes
    pending_bets.sum(:stake) + pending_combo_bets.sum(:stake)
  end

  def profitability
    (average_won - average_lost) / (average_lost.nonzero? || 1)
  end

  def pl
    pl = winnings - total_stakes
  end

  def bets
    @bets ||= user.bets.not_combo
  end

  def pending_bets
    @pending_bets ||= bets.pending
  end

  def combo_bets
    @combo_bets ||= user.combo_bets
  end

  def pending_combo_bets
    @pending_combo_bets ||= combo_bets.pending
  end

  def total_settlement(bets:)
    OpenStruct.new(
      total_bets: bets.count,
      total_odds: bets.sum('odds::float').to_f,
      total_stakes: bets.sum(:stake).to_f
    )
  end

  def calculate_average_settlement(status:)
    bets_data = total_settlement(bets: bets.send(status))
    combo_bets_data = total_settlement(bets: combo_bets.send(status))

    total_bets = bets_data.total_bets + combo_bets_data.total_bets
    average_odds = (bets_data.total_odds + combo_bets_data.total_odds) / (total_bets.nonzero? || 1)
    average_stake_amount = (bets_data.total_stakes + combo_bets_data.total_stakes) / (total_bets.nonzero? || 1)

    total_bets * average_odds * average_stake_amount
  end

  def average_won
    calculate_average_settlement(status: :won)
  end

  def average_lost
    calculate_average_settlement(status: :lost)
  end

  def current_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M %a')
    return 'NA' if date.blank?

    date&.in_time_zone(zone)&.strftime(format)
  end
end
