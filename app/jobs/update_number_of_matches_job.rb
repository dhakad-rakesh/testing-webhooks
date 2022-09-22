class UpdateNumberOfMatchesJob < ApplicationJob
  queue_as :low

  def perform
    Tournament.active_tournaments.find_each do |tournament|
      tournament.update_column(:number_of_matches, tournament.matches.upcoming.schedulable.count)
    end

    Sport.active_sports.find_each do |sport|
      sport.sport_countries.each do |sport_country|
        mataches_count = Tournament.where(country_id: sport_country.country_id,
                                          sport_id: sport.id, enabled: true).pluck(:number_of_matches).sum
        sport_country.update_column(:number_of_matches, mataches_count)
      end
      sport.update_column(:number_of_matches, sport.sport_countries.sum(:number_of_matches))
    end
  end
end
