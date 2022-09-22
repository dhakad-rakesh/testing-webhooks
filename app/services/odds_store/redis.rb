module OddsStore
  class Redis
    class << self

      def read(key)
        formatted_response(service.hgetall(key.first))
      end

      def write(key, data)
        service.hmset(key.first, *formatted_input(data))
      end

      def read_hash(hash, key)
        data = service.hget(hash.first, key)
        JSON.parse(data).with_indifferent_access if data.present?
      end

      def write_hash(hash, key, data)
        service.hset(hash.first, key, data.to_json)
      end

      def read_multiple_keys(hash, keys)
        multikey_response(service.hmget(hash.first, *keys).compact)
      end

      def remove_hash(hash)
        service.del(hash.first)
      end

      # Specify service instance here
      def service
        REDIS
      end

      # Don't do this... . Think of something else or Adapt Rejson
      def formatted_response(data)
        data.each { |k,v| data[k] = JSON.parse(v) }
        { markets: data }.with_indifferent_access
      end

      def formatted_input(data) 
        data[:markets].each { |k,v| data[:markets][k] = v.to_json }
        data[:markets].to_a.flatten
      end

      def multikey_response(data)
        markets = {}
        data.each do |market_data|
          market_data = JSON.parse(market_data)
          markets[market_data['uid']] = market_data
        end
        { markets: markets }.with_indifferent_access
      end
    end
  end
end
