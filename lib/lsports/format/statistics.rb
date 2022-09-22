module Lsports
  module Format
    class Statistics
      attr_reader :match

      def initialize(match)
        @match = match
      end

      def call
        return unless match.results.present?
        statistics
      end

      def statistics
        formatted_stats = {}
        stats.each do |stat|
          name = Constants::LSPORTS_STATISTIC_MAP[stat[:Type]]
          next unless name
          formatted_stats[name] = { name: name, values: values(stat[:Results]) }
        end
        formatted_stats
      end

      def stats
        match.results[:Statistics] || []
      end

      def values(results)
        values = {}
        results.each do |result|
          values[result[:Position]] = result
        end
        values
      end
    end
  end
end
