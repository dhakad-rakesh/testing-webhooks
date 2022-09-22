class AccumulatorBetSerializer < BaseSerializer
  attributes :id, :odds, :stake, :status, :date, :to_win, :current_odds, :cashout_amount, :play_number

  has_many :bets

  def date
    object.created_at.strftime('%m/%d')
  end

  def to_win
    return (object.odds.to_f * object.stake).round(8) if object.pending?
  end

  def current_odds
    odds = object.bets.map { |bet| (bet.current_odds.presence || bet.odds).to_f }
    odds = odds.inject(1, &:*).round(2)
    return nil if odds.zero?
    odds
  end

  def cashout_amount
    return unless object.pending?
    cashout_odds = current_odds
    return object.stake if cashout_odds.blank?
    ((object.odds.to_f / cashout_odds) * object.stake).round(8)
  end
end
