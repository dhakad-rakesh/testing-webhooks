module OddsStore
  class Memcache
    class << self

      def read(key)
        service.read(key)
      end

      def write(key, data)
        service.write(key, data)
      end

      # TODO: Add implementation
      def read_hash(hash, key)
        raise NotImplementedError
      end

      # TODO: Add implementation
      def write_hash(hash, key, data)
        raise NotImplementedError
      end

      # Specify service instance here
      def service
        Rails.cache
      end
    end
  end
end
