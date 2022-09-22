class CategoriseTournamentJob < ApplicationJob
  queue_as :low
  def perform(tournament_id)
    tournament = Tournament.find(tournament_id)
    Soccer::CategoriseTournament.run!(tournament: tournament)
  end
end
