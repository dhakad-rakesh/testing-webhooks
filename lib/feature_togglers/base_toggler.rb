module FeatureTogglers
  class BaseToggler
    class << self
      def activated?
        active
      end

      def deactivated?
        !active
      end

      def activate
        Rails.cache.write(toggle_key, true)
      end

      def deactivate
        Rails.cache.write(toggle_key, false)
      end

      def toggle(active)
        active ? deactivate : activate
      end

      def toggle_key
        raise NotImplementedError
      end

      private

      # Activated by default
      def active
        return true if cache_status.nil?
        cache_status
      end

      def cache_status
        Rails.cache.fetch(toggle_key) == true
      end
    end
  end
end
