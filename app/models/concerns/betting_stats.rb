module BettingStats
  extend ActiveSupport::Concern

  included do
    scope :resolved, -> { where(status: %w[won lost refunded cashed_out cancelled]) }
    scope :played, -> { where(status: %w[won lost refunded pending cashed_out]) }
    scope :total_betting_amount, -> { joins(:user).group(:user_id, 'users.username').sum(:stake) }
    scope :total_predictions_per_user, -> { resolved.group(:user_id).sum(1) }
    scope :lost_amount_per_user, -> { where(status: 'lost').group(:user_id).sum(:stake) }
    scope :won_amount_per_user, -> { where(status: 'won').group(:user_id).sum('stake * (CAST (odds AS FLOAT) - 1)') }
    scope :cashed_out_amount_won_per_user, (lambda do
      cashed_out.where('cashed_out_amount > stake')
                .group(:user_id).sum('cashed_out_amount - stake')
    end)
    scope :qualified_users, (lambda do
      joins(:user).group(:user_id)
                  .having("count(*) >= #{Constants::LEADERBOARD_MINIMUM_CRITERIA_BETS}")
                  .sum(1)
    end)

    scope :total_pending_amount, -> { where(status: 'pending').group(:user_id).sum(:stake) }
    scope :average_odds_per_user, -> { group(:user_id).average('(CAST (odds AS FLOAT))') }
  end
end
