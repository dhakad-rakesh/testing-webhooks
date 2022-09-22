module Leaderboards
  module UserStats
    def won_amount_per_user
      @won_amount_per_user ||= filtered_bets.won_amount_per_user
                                            .union_with_sum(filtered_accumulator_bets.won_amount_per_user)
    end

    def cashed_out_amount_won_per_user
      @cashed_out_amount_won_per_user ||= filtered_bets.cashed_out_amount_won_per_user
                                                       .union_with_sum(filtered_accumulator_bets
                                                                      .cashed_out_amount_won_per_user)
    end

    def qualified_users
      @qualified_users ||= filtered_bets.qualified_users.keys
    end

    def points_gained_per_user
      @points_gained_per_user ||= won_amount_per_user
                                  .union_with_sum(cashed_out_amount_won_per_user)
    end

    def lost_amount_per_user
      @lost_amount_per_user ||= filtered_bets.lost_amount_per_user
                                             .union_with_sum(filtered_accumulator_bets.lost_amount_per_user)
    end

    def total_predictions_per_user
      @total_predictions_per_user ||= filtered_bets.total_predictions_per_user
                                                   .union_with_sum(filtered_accumulator_bets.total_predictions_per_user)
    end

    def total_betting_amount
      @total_betting_amount ||= filtered_bets.total_betting_amount
                                             .union_with_sum(filtered_accumulator_bets.total_betting_amount)
    end

    def total_pending_amount
      @total_pending_amount ||= filtered_bets.total_pending_amount
                                             .union_with_sum(filtered_accumulator_bets.total_pending_amount)
    end

    def average_gain_per_user
      @average_gain_per_user ||= calculate_average_gain_per_user
    end

    def average_odds_per_user
      @average_odds_per_user ||= filtered_bets.average_odds_per_user
                                              .union_with_average(filtered_accumulator_bets.average_odds_per_user)
    end

    def calculate_rank_percentage(total, won_amount)
      total.positive? ? (won_amount / total * 100).round(2) : 0.0
    end
  end
end
