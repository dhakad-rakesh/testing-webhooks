module FeatureTogglers
  module WriteOddsToPersistentLayer
    class Toggler < FeatureTogglers::BaseToggler
      def self.toggle_key
        'WRITE_ODDS_TO_PERSISTENT_LAYER'      
      end
    end
  end
end

