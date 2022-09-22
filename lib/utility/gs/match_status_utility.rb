module Utility
  module GS
    class MatchStatusUtility
      def self.load_status(status)
        case status
        when 'not_started'
          '0'
        when 'in_progress'
          '1'
        when 'cancelled'
          '3'
        when 'suspended'
          '2'
        when 'interrupted'
          '3'
        when 'delayed'
          '2'
        when 'abandoned'
          '4' 
        when 'postponed'
          '2'
        else
          '2'
        end
      end
    end
  end
end
