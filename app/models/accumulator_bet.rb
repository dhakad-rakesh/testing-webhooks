class AccumulatorBet < ApplicationRecord
  include BettingStats

  belongs_to :user
  belongs_to :betting_pool, optional: true
  belongs_to :wallet
  enum status: { pending: 0, won: 1, lost: 2, refunded: 3, hold: 4, cashed_out: 5 }
  has_many :bets, dependent: :destroy
  has_many :ledgers, as: :betable, dependent: :destroy

  after_touch :update_stake_and_odds

  def eligible_for_cashout?
    pending? && bets.map(&:status).uniq.count == 1 && bets.map(&:status).first == 'pending'
  end

  private

  def update_stake_and_odds
    return destroy if bets.blank?
    self.odds = bets.map { |bet| bet.odds.to_f }.inject(1, &:*).round(2)
    save
  end
end
