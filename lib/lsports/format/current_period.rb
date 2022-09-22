module Lsports
  module Format
    class CurrentPeriod
      attr_reader :match, :live_score

      def initialize(match)
        @match = match
        @live_score = match.results
      end

      def call
        return unless live_score.present?
        current_period
      end

      def current_period
        periods.each do |period|
          if period[:Type] == current_period_type
            name = fetch_name(period[:Type])
            return { name: name, values: values(period[:Results]) } if name
          end
        end
        nil
      end

      def values(results)
        values = {}
        results.each do |result|
          values[result[:Position]] = result
        end
        values
      end

      def current_period_type
        @current_period_type ||= live_score.dig(:Scoreboard, :CurrentPeriod)
      end

      def periods
        live_score[:Periods] || []
      end

      def fetch_name(type)
        name = Constants::LSPORTS_PERIOD_MAP[type]
        require_custom_suffix?(type) ? name + custom_suffix : name
      end

      def require_custom_suffix?(type)
        [1, 2, 3, 4, 5].include?(type)
      end

      def custom_suffix
        case match.sport.uid.to_i
        when 131506 # American Football
          ' Quarter'
        when 48242 # Basketball
          ' Quarter'
        when 452674 # Cricket 
          ' Inning'
        when 54094 # Tennis
          ' Set'
        else # E-Sports
          ' Map'
        end
      end
    end
  end
end
