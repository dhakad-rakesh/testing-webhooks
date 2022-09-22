module LS
  class SportOddsChangeJob < ApplicationJob
    queue_as :odds_change

    def perform(sport_uid, update_odds = false)
      # Odds update should be done from RMQ listener, now we only used this job to enable and disable matches.
      # Still we can pass update_odds = true to initialy save odds. 
      json_data = fetch_json(sport_uid)

      enabled_match_ids = []
      disabled_match_ids = []

      json_data.each do |data|
        match = Match.find_by(uid: data[:event_id])
        next if match.blank?

        if match.not_started?
          data[:odds][:markets].present? ? (enabled_match_ids << data[:event_id]) : (disabled_match_ids << data[:event_id])
          MatchMarketOddsChangeJob.perform_later(data) if update_odds 
        end
      end

      Match.where(uid: enabled_match_ids).update_all(enabled: true)
      Match.where(uid: disabled_match_ids).update_all(enabled: false)
    end

    private

    def fetch_json(sport_uid)
      sport = Sport.find_by uid: sport_uid
      Lsports::Format::PrematchOdds.new(sport).call
    end
  end
end
