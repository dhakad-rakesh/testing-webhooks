module PoolBetting
  class Payout < ApplicationJob
    def perform(pool_id)
      pool = BettingPool.find_by(id: pool_id)
      return if pool.blank?
      pool.entry_amount * pool.participants.size
      # Distribute prize according to leaderboard
    end
  end
end
