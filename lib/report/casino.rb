module Report
  class Casino
    attr_reader :start_date, :end_date, :game, :data, :start, :finish

    def initialize(start_date: nil, end_date: nil, game: nil, page: 1)
      @start_date = start_date
      @end_date = end_date
      @game = game
      @data = []
      if page.eql?('all')
        @start = 1
        @finish = CasinoItem.count
      else
        @start = page.to_i == 1 ? 1 : ((page.to_i - 1) * Constants::PER_PAGE) + 1
        @finish = Constants::PER_PAGE * page.to_i
      end
    end

    def call
      return Array.wrap(stats(game: game)) if game.present?

       CasinoItem.find_in_batches do |group|
         group.each { |game| data << stats(game: game) }
       end

      data
    end

    # def to_csv
    #   attributes = %w[Sport Stakes Winning P/L Profitability]

    #   CSV.generate(headers: true) do |csv|
    #     csv << attributes

    #     call.each do |sport|
    #       csv << [sport.sport, sport.stakes.round(2), sport.winning.round(2), sport.pl.round(2), sport.profitability.round(2)]
    #     end
    #   end
    # end

    private

    def stats(game:)
      OpenStruct.new(
        name: game.name,
        provider: game.provider,
        stakes: stakes(game: game),
        refunds: refunds(game: game),
        winning: winnings(game: game),
        pl: pl(game: game),
        ggr: ggr(game: game),
        average_stake: average_stake(game: game),
        bonus_utilized: bonus_utilized(game: game)
      )
    end

    def average_stake(game:)
      stakes(game: game) / (session_transactions_for(game: game, type: 'bet').count.nonzero? || 1)
    end

    def stakes(game:)
      session_transactions_for(game: game, type: 'bet').sum('ledgers.amount')
    end

    def refunds(game:)
      session_transactions_for(game: game, type: 'refund').sum('ledgers.amount')
    end

    def winnings(game:)
      session_transactions_for(game: game, type: 'win').sum('ledgers.amount')
    end

    def pl(game:)
      stakes(game: game) - winnings(game: game)
    end

    def ggr(game:)
      0
    end

    def bonus_utilized(game:)
      session_transactions_for(game: game, type: 'bet').sum('session_transactions.utilized_bonus')
    end

    def session_transactions_for(game:, type:)
      game_transactions(game: game).transactions_for(type)
    end

    def game_transactions(game:)
      return game.session_transactions.casino unless start_date && end_date

      game.session_transactions.casino.between(start_date, end_date)
    end
  end
end
