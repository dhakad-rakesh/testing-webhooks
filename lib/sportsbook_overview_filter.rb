class SportsbookOverviewFilter
  attr_reader :start_date, :end_date, :kind, :user_ids

  def initialize(kind:, start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @kind = kind
    @user_ids = user_ids
  end

  def finance
    @finance ||= OpenStruct.new(
      turnover: turnover,
      winning_amount: winning_amount,
      open_bets_single: open_bets_single,
      open_bets_combo: open_bets_combo,
      ggr: ggr,
      profitability: profitability,
      number_of_single_bets: number_of_single_bets,
      number_of_combo_bets: number_of_combo_bets,
      average_bet: average_bet,
      number_of_players: number_of_players,
      bets_per_player: bets_per_player
    )
  end

  def turnover
    return @turnover if @turnover.present?

    prematch = source.pregame.sum('stake - bonus_stake')
    live = source.inplay.sum('stake - bonus_stake')
    total = source.sum('stake - bonus_stake')

    @turnover ||= OpenStruct.new(prematch: prematch,
                                 live: live,
                                 total: total)
  end

  def winning_amount
    return @winning_amount if @winning_amount.present?

    prematch = source.pregame.won.sum(:winnings)
    live = source.inplay.won.sum(:winnings)
    total = source.won.sum(:winnings)

    @winning_amount ||= OpenStruct.new(prematch: prematch,
                                       live: live,
                                       total: total)
  end

  def open_bets_single
    prematch = source.not_combo.pregame.pending.count
    live = source.not_combo.inplay.pending.count
    total = prematch + live

    OpenStruct.new(prematch: prematch,
                   live: live,
                   total: total)
  end

  def open_bets_combo
    prematch = source.combo_bets.pregame.pending.select(:combo_bet_id).distinct.count
    live = source.combo_bets.inplay.pending.select(:combo_bet_id).distinct.count
    total = source.combo_bets.pending.select(:combo_bet_id).distinct.count

    OpenStruct.new(prematch: prematch,
                   live: live,
                   total: total)
  end

  def ggr
    # prematch = turnover.prematch - winning_amount.prematch
    # live = turnover.live - winning_amount.live
    # total = prematch + live
    return @ggr if @ggr.present?

    prematch = 0
    live = 0
    total = 0

    @ggr ||= OpenStruct.new(prematch: prematch,
                            live: live,
                            total: total)
  end

  def profitability
    # (average_won - average_lost) / (average_lost.nonzero? || 1) 0.0

    prematch = turnover.prematch - winning_amount.prematch - ggr.prematch
    live = turnover.live - winning_amount.live - ggr.live
    total = prematch + live

    OpenStruct.new(prematch: prematch,
                   live: live,
                   total: total)
  end

  def number_of_single_bets
    return @number_of_single_bets if @number_of_single_bets.present?

    prematch = source.not_combo.pregame.count
    live = source.not_combo.inplay.count
    total = source.not_combo.count

    @number_of_single_bets = OpenStruct.new(prematch: prematch,
                                           live: live,
                                           total: total)
  end

  def number_of_combo_bets
    return @number_of_combo_bets if @number_of_combo_bets.present?

    prematch = source.combo_bets.pregame.select(:combo_bet_id).distinct.count
    live = source.combo_bets.inplay.select(:combo_bet_id).distinct.count
    total = source.combo_bets.select(:combo_bet_id).distinct.count

    @number_of_combo_bets = OpenStruct.new(prematch: prematch,
                                           live: live,
                                           total: total)
  end

  def average_bet
    # turnover / (number_of_bets.nonzero? || 1)
    prematch = turnover.prematch / ((number_of_single_bets.prematch + number_of_combo_bets.prematch).nonzero? || 1)
    live = turnover.live / ((number_of_single_bets.live + number_of_combo_bets.live).nonzero? || 1)
    total = turnover.total / ((number_of_single_bets.total + number_of_combo_bets.total).nonzero? || 1)

    OpenStruct.new(prematch: prematch,
                   live: live,
                   total: total)
  end

  def number_of_players
    return @number_of_players if @number_of_players.present?

    prematch = source.pregame.select(:user_id).distinct.count
    live = source.inplay.select(:user_id).distinct.count
    total = prematch + live

    @number_of_players = OpenStruct.new(prematch: prematch,
                                        live: live,
                                        total: total)
  end

  def bets_per_player
    # number_of_bets / (number_of_players.nonzero? || 1)
    prematch = turnover.prematch / (number_of_players.prematch.nonzero? || 1)
    live = turnover.live / (number_of_players.live.nonzero? || 1)
    total = turnover.total / (number_of_players.total.nonzero? || 1)

    OpenStruct.new(prematch: prematch,
                   live: live,
                   total: total)
  end

  private

  def source
    return source_by_role.by_sport_kind(kind) unless start_date && end_date

    source_by_role.by_sport_kind(kind).between(start_date, end_date)
  end

  def source_by_role
    return Bet if user_ids.eql?(:all)

    Bet.by_users(user_ids)
  end
end
