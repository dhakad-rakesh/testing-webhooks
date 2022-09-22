module Utility
  class MatchStatusUtility
    def self.load_status
      Rails.cache.fetch('match_statuses') do
        YAML.load_file('config/match_statuses.yml')
      end
    end
  end
end
