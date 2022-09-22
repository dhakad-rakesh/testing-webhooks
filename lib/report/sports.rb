module Report
  class Sports
    attr_reader :start_date, :end_date, :source, :play_type

    def initialize(start_date: nil, end_date: nil, play_type: :all)
      @start_date = start_date
      @end_date = end_date
      @play_type = play_type || :all
    end

    def call
      Sport.visible.map { |sport| stats(sport: sport) }
    end

    def to_csv
      attributes = %w[Sport Stakes Winning P/L Profitability]

      CSV.generate(headers: true) do |csv|
        csv << attributes

        call.each do |sport|
          csv << [sport.sport, sport.stakes.round(8), sport.winning.round(8), sport.pl.round(2), sport.profitability.round(2)]
        end
      end
    end

    private

    def stats(sport:)
      bets = sport_bets(sport: sport)
      bets = bets.where("bets.play_type = ?", Bet.play_types[play_type]) if play_type != :all
      stakes = bets.sum(:stake)
      winnings = bets.sum(:winnings)
      pl = bets.sum(:profit)
      turnover = bets.sum('stake - bonus_stake')
      profitability = turnover - winnings #- ggr(sport: sport)

      OpenStruct.new(
        sport: sport.name,
        stakes: stakes,
        winning: winnings,
        pl: pl,
        profitability: profitability
      )
    end

    def ggr(sport:)
      0
    end

    # def profitability(sport:)
      # turnover = sport_bets(sport: sport).sum('stake - bonus_stake')

      # average_won = average_won(sport: sport)
      # average_lost = average_lost(sport: sport)

      # (average_won - average_lost) / (average_lost.nonzero? || 1)
    # end

    # def average_won(sport:)
    #   average_settlement(sport: sport, status: :won)
    # end

    # def average_lost(sport:)
    #   average_settlement(sport: sport, status: :lost)
    # end

    # def average_settlement(sport:, status:)
    #   total_bets = sport_bets(sport: sport).send(status).count
    #   average_odds = sport_bets(sport: sport).send(status).average('odds::float').to_f
    #   average_stake_amount = sport_bets(sport: sport).send(status).average(:stake).to_f
  
    #   total_bets * average_odds * average_stake_amount
    # end

    def sport_bets(sport:)
      return sport.bets unless start_date && end_date

      sport.bets.between(start_date, end_date)
    end
  end
end