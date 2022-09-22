class ProfitFilter
  attr_reader :start_date, :end_date, :user_ids

  def initialize(start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @user_ids = user_ids
  end

  def stats
    {
      sports: sports_data_by(kind: :sports),
      esports: sports_data_by(kind: :esports),
      casino: casino_stats,
      slot: slot_stats
    }
  end

  private

  def casino_stats
    bet = session_transactions_for(type: 'bet', game: 'casino').sum('ledgers.amount')
    win = session_transactions_for(type: 'win', game: 'casino').sum('ledgers.amount')
    {
      bet: bet.round(6) || 0,
      win: win.round(6) || 0
    }
  end

  def slot_stats
    bet = session_transactions_for(type: 'bet', game: 'slot_game').sum('ledgers.amount')
    win = session_transactions_for(type: 'win', game: 'slot_game').sum('ledgers.amount')
    {
      bet: bet.round(6) || 0,
      win: win.round(6) || 0
    }
  end

  def sports_data_by(kind:)
    bet = bets_by(kind: kind).pluck(Arel.sql('SUM(stake)')).last
    win = bets_by(kind: kind).settled.pluck(Arel.sql('SUM(winnings)')).last
    {
      bet: bet&.round(6) || 0,
      win: win&.round(6) || 0
    }
  end

  def bets_by(kind:)
    return source_by_role.by_sport_kind(kind) unless start_date && end_date

    source_by_role.by_sport_kind(kind).between(start_date, end_date)
  end

  def source_by_role
    return Bet if user_ids.eql?(:all)

    Bet.by_users(user_ids)
  end

  def session_transactions_for(type:, game:)
    game_transactions(game).transactions_for(type)
  end

  def game_transactions(game)
    return SessionTransaction.try(game) unless start_date && end_date

    SessionTransaction.try(game).between(start_date, end_date)
  end
end
