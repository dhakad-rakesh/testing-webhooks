module LS
  module Inplay
    class DisableMatchJob < ApplicationJob
      queue_as :disable_match

      def perform
        matches_ids = Match.where("schedule_at < ? and status != ? and inplay_subscribed = ?", Time.zone.now, "ended", false).pluck(:id)
        Match.where(id: matches_ids).update_all(enabled: false, highlight: false)
        Match.where(id: matches_ids, status: Match::CASHOUTABLE_STATES).update_all(status: 'ended')
        # For next iteration
        Match.where(status: %w[started in_progress about_to_start]).update_all(inplay_subscribed: false)
      end
    end
  end
end
