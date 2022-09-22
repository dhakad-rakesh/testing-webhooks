module GS
  class MatchDisableJob < ApplicationJob
    queue_as :disable_matches

    def perform
      while true
        sleep 10
        if Sidekiq::Queue.new("odds_change").size != 0
          puts 'Odds change queues are running....'
        else
          # Disable matches which don't have odds data.
          matches = Match.active_matches
                         .select{|m| m.odds_data.blank? || m.odds_data[:markets].blank? }

          matches.map(&:disable)
          puts "Disable matches are done............"
          break
        end
      end
    end
  end
end