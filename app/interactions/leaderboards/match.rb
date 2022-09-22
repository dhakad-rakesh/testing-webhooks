module Leaderboards
  class Match < Leaderboards::Base
    object :match

    # Get all bets on the match to be considered for leaderboard calculations
    def filtered_bets
      filter_bets = Bet.played.traditional
      filter_bets = filter_bets.where(match_id: match.id) if match&.id.present?
      filter_bets
    end

    # No accumualator bets are considered for match leaderboard calculations
    def filtered_accumulator_bets
      AccumulatorBet.none
    end
  end
end
