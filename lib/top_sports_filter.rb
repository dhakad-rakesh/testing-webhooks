class TopSportsFilter
  attr_reader :start_date, :end_date, :sports_data, :user_ids

  def initialize(start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @user_ids = user_ids
    @sports_data = {}
  end

  def stats
    return sports_data if sports_data.present?
    sports_data[:sports] = sport_kind_stats(sport_kind: :sports)
    sports_data
  end

  private

  def sport_kind_stats(sport_kind:)
    top_5_sport_ids(sport_kind: sport_kind).map { |sport_id| sport_stats(sport_id: sport_id) }
  end

  def top_5_sport_ids(sport_kind:)
    top_ids = Sport.send(sport_kind)
                   .visible
                   .joins(:bets)
                   .where(bets: bets_filter)
                   .group(:id)
                   .sum(:profit)
                   .sort_by { |_, count| -count }
                   .first(5)
                   .map(&:first)

    top_5_selection(ids: top_ids, sport_kind: sport_kind)
  end

  def top_5_selection(ids:, sport_kind:)
    return ids if ids.count == 5

    (ids | Sport.send(sport_kind).visible.sort_by_rank.ids).first(5)
  end

  def sport_stats(sport_id:)
    sport = Sport.find_by(id: sport_id)
    # filtered_bets = sport_bets(sport: sport)
    # total_stakes
    # profit = total stakes - winning
    total_bets_amount = sport_bets(sport: sport).sum(:stake)
    total_winnings = sport_bets(sport: sport).sum(:winnings)
    profit = sport_bets(sport: sport).sum(:profit)

    profit_percentage = (profit / (total_bets_amount.nonzero? || 1)) * 100

    OpenStruct.new(
      name: sport.name,
      total_bets_amount: total_bets_amount,
      total_winnings: total_winnings,
      profit: profit,
      profit_percentage: profit_percentage
    )
  end

  def sport_bets(sport:)
    return source_by_role(sport: sport) unless start_date && end_date

    source_by_role(sport: sport).between(start_date, end_date)
  end

  def source_by_role(sport:)
    return sport.bets.settled if user_ids.eql?(:all)

    sport.bets.settled.by_users(user_ids)
  end

  def date_filter
    return { created_at: Date.new..Time.zone.now } unless start_date && end_date

    { created_at: start_date.beginning_of_day..end_date.end_of_day }
  end

  def bets_filter
    return date_filter if user_ids.eql?(:all)

    date_filter.merge(user_id: user_ids)
  end
end
