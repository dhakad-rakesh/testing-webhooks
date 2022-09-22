module LS
  class OddsChangeJob < ApplicationJob
    queue_as :odds_change

    def perform(update_odds = false)
      # Odds update should be done from RMQ listener, now we only using this job to enable and disable matches.
      # Still we can pass update_odds = true to initialy save odds. 
      sports.pluck(:uid).each_with_index do |uid, index|
        SportOddsChangeJob.set(wait: (index + 1).minutes).perform_later(uid, update_odds)
      end
    end

    private

    def sports
      Sport.sports.active_sports
    end
  end
end
