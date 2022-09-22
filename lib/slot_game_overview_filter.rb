class SlotGameOverviewFilter
  attr_reader :start_date, :end_date, :user_ids

  def initialize(start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @user_ids = user_ids
  end

  def finance
    @finance ||= OpenStruct.new(
      turnover: turnover,
      winning_amount: winning_amount,
      ggr: ggr,
      profitability: profitability,
      average_bet: average_bet,
      number_of_players: number_of_players
    )
  end

  def turnover
    return @turnover if @turnover.present?
    @turnover ||= OpenStruct.new(total: stakes)
  end

  def stakes(type: nil)
    game_transactions.transactions_for('bet').sum('ledgers.amount - utilized_bonus') unless type.present?
  end

  def winning_amount
    return @winning_amount if @winning_amount.present?
    @winning_amount ||= OpenStruct.new(total: winnings)
  end

  def winnings(type: nil)
    game_transactions.transactions_for('win').sum('ledgers.amount') unless type.present?
  end

  def ggr
    return @ggr if @ggr.present?
    @ggr ||= OpenStruct.new(total: 0)
  end

  def profitability
    return @profitability if @profitability.present?
    total = turnover.total - winning_amount.total - ggr.total
    @profitability ||= OpenStruct.new(total: total)
  end

  def average_bet
    return @average_bet if @average_bet.present?
    total = stakes / (game_transactions.transactions_for('bet').count.nonzero? || 1)
    @average_bet ||= OpenStruct.new(total: total)
  end

  def number_of_players
    return @number_of_players if @number_of_players.present?
    total = game_transactions.pluck(:player_id).uniq.count
    @number_of_players ||= OpenStruct.new(total: total)
  end

  def game_transactions
    return SessionTransaction.slot_game unless start_date && end_date

    SessionTransaction.slot_game.between(start_date, end_date)
  end
end
