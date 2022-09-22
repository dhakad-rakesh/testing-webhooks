class TopSlotGameFilter
  attr_reader :start_date, :end_date, :casino_data, :user_ids

  def initialize(start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @user_ids = user_ids
  end

  def stats
    @stats ||= top_slot_game_ids.map { |game_id| slot_game_stats(game_id: game_id) }
  end

  private

  def top_slot_game_ids
    SlotGame.all.map { |game| [game.id, pl(game: game)] }
                  .sort_by { |_, profit| -profit }
                  .first(5)
                  .map(&:first)
  end

  def slot_game_stats(game_id:)
    game = SlotGame.find_by(id: game_id)
    total_stake_amount = stakes(game: game)
    total_winnings = winnings(game: game)
    profit = pl(game: game)

    profit_percentage = (profit / (total_stake_amount.nonzero? || 1)) * 100

    OpenStruct.new(
      name: game.name,
      total_stake_amount: total_stake_amount,
      total_winnings: total_winnings,
      profit: profit,
      profit_percentage: profit_percentage
    )
  end

  def pl(game:)
    stakes(game: game) - winnings(game: game)
  end

  def stakes(game:)
    session_transactions_for(game: game, type: 'bet').sum('ledgers.amount')
  end

  def winnings(game:)
    session_transactions_for(game: game, type: 'win').sum('ledgers.amount')
  end

  def session_transactions_for(game:, type:)
    game_transactions(game: game).transactions_for(type)
  end

  def game_transactions(game:)
    return game.session_transactions unless start_date && end_date

    game.session_transactions.between(start_date, end_date)
  end
end
