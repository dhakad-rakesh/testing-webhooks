module Sportradar
  module Soccer
    class Client < ::Sportradar::Base
      attr_accessor :league_group, :access_level
      VERSION = 3
      def initialize(league_group)
        @league_group = league_group.downcase
        @access_level = default_access_level
      end

      def default_access_level
        't' unless Rails.env.production?
      end

      def api_key
        @api_key ||= Figaro.env.send("sportradar_soccer_#{@league_group}_key")
      end

      def daily_schedule(schedule_date = nil)
        schedule_date ||= Time.zone.today
        schedule_date = Time.zone.parse(schedule_date.to_s).to_date.to_s
        get_data("schedules/#{schedule_date}/schedule").with_indifferent_access
      end

      # Provides information for Soccer tournaments
      def tournament_info(tournament_id)
        get_data("/tournaments/#{tournament_id}/info").with_indifferent_access
      end

      # Provides the results for Soccer tournaments
      def tournament_results(tournament_id)
        get_data("/tournaments/#{tournament_id}/results")
      end

      private

      def request_url(path)
        "#{base_url}/soccer-#{access_level}#{VERSION}/#{league_group}/en/#{path}.json?api_key=#{api_key}"
      end
    end
  end
end
