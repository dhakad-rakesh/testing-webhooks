module FeatureTogglers
  module PrematchRealtimeUpdates
    class Toggler < FeatureTogglers::BaseToggler
      def self.toggle_key
        'PREMATCH_REALTIME_UPDATES'      
      end
    end
  end
end

