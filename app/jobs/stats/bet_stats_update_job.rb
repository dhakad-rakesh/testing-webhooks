class Stats::BetStatsUpdateJob < ApplicationJob
  queue_as :stats_update

  def perform(bet_id, combo_bet=true)
    bet = combo_bet ? ComboBet.find_by(id: bet_id) : Bet.find_by(id: bet_id)
    return if bet.blank?
    BetStats::Update.new(bet: bet).call
  end
end
