include Sidekiq::Worker

# TODO: Find a suitable name... .DRY both status update jobs
module LS
  module Inplay
    class NewMatchStatusUpdateJob
      include Utility::JobUtility::PublishDataUtility
      include Sidekiq::Worker
      include RedisMutex::Macro

      auto_mutex :perform, on: [:fixture_id], block: 10, after_failure: lambda { Rails.cache.write('status_failure_count', Rails.cache.read('failure_count') + 1 ) }
      sidekiq_options queue: 'inplay_score_change'

      def perform(fixture_id, fixture_data)
        data = fixture_data.with_indifferent_access
        scoreboard = data.dig(:Livescore, :Scoreboard)
        return if scoreboard.nil?

        match = Match.find_by uid: data[:FixtureId].to_s
        return if match.nil?

        ls_status = scoreboard.dig(:Status)
        status = match.load_ls_status(ls_status) unless ls_status.nil?

        if (match.about_to_start? || match.coverage? || match.not_started?) && status == 'in_progress' && match.live == false
          match.live = true
          OddStore.new(match.uid).remove_odds_data # Remove prematch markets data
        end

        # Subscribed Inplay
        if status == 'in_progress'
          unless match.inplay_subscribed || match.enabled?
            match.inplay_subscribed = true
            match.enabled = true
          end
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
