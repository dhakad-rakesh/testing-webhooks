class CategoriseTournamentsJob < ApplicationJob
  queue_as :low
  def perform
    Tournament.select('id').find_each(batch_size: 10) do |tournament|
      CategoriseTournamentJob.perform_later(tournament.id)
    end
  end
end
