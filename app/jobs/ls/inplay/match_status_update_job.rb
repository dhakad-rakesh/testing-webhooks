include Sidekiq::Worker

module LS
  module Inplay
    class MatchStatusUpdateJob < ApplicationJob
      include Utility::JobUtility::PublishDataUtility

      def perform(fixture_data)
        data = fixture_data.with_indifferent_access
        scoreboard = data.dig(:Livescore, :Scoreboard)
        return if scoreboard.nil?

        match = Match.find_by uid: data[:FixtureId].to_s
        return if match.nil?

        ls_status = scoreboard.dig(:Status)
        status = match.load_ls_status(ls_status) unless ls_status.nil?

        if (match.about_to_start? || match.coverage? || match.not_started?) && status == 'in_progress' && match.live == false
          match.live = true
          OddStore.new(match.id).odds_data = { markets: {} }
        end

        # Subscribed Inplay
        if status == 'in_progress'
          match.inplay_subscribed = true unless match.inplay_subscribed
        end

        match.status = status unless ls_status.nil?
        if match.changed?
          match.save
          publish_status_updates(match)
        end
      end
    end
  end
end
