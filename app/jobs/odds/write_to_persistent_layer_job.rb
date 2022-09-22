module Odds
  class WriteToPersistentLayerJob < ApplicationJob
    queue_as :low

    def perform(match_id, odds_data, time_params)
      match = Match.find_by(id: match_id)
      return unless match.present?
      snapshot_time = Time.zone.at(Rational(*time_params.values))
      Odds::WriteToPersistentLayer.run!(match: match, odds_data: odds_data, snapshot_time: snapshot_time)
    end
  end
end