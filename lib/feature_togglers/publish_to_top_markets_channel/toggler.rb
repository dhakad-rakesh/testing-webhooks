module FeatureTogglers
  module PublishToTopMarketsChannel
    class Toggler < FeatureTogglers::BaseToggler
      def self.toggle_key
        'PUBLISH_TO_TOP_MARKETS_CHANNEL'      
      end
    end
  end
end

