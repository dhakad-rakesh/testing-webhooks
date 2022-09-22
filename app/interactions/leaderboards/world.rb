module Leaderboards
  class World < Leaderboards::Base
    date :start_date, default: nil

    # Get all bets between the given time frame to be considered for leaderboard calculations
    def filtered_bets
      filter_bets = Bet.played.traditional
      filter_bets = filter_bets.where('bets.created_at > ?', start_date) if start_date.present?
      filter_bets
    end

    # Get all accumualtor bets between the given time frame to be considered for leaderboard calculations
    def filtered_accumulator_bets
      filter_accumulator_bets = AccumulatorBet.played
      if start_date.present?
        filter_accumulator_bets = filter_accumulator_bets.where('accumulator_bets.created_at > ?', start_date)
      end
      filter_accumulator_bets
    end
  end
end
