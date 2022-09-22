module LS
  class RefundPendingBetsJob < ApplicationJob
    queue_as :result_process
    
    def perform
      bets = Bet.joins(:match).where('matches.schedule_at < ? AND bets.status = ?', DateTime.current.beginning_of_day - 2.days, Bet.statuses[:pending])
      bets.each do |bet|
        Betting::LS::DirectBetResult.run(data: { match: bet.match, market: bet.market,  bets: [bet], status: 'refunded', specifiers: {} })
      end
    end
  end
end