module LS
  class CreateMatchJob < ApplicationJob
    queue_as :low
    include LS::SportUtility

    def perform(fixture_id, fixture)
      fixture = fixture.with_indifferent_access
      @tournament = Sportable::Create::Tournaments.run!(fetch_tournament_data(fixture))
      return unless @tournament.enabled # not creating matches for disable tournaments
      create_match(fixture_id, fixture)
    end
  end
end
