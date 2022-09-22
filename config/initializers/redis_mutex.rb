url = ENV.fetch('sidekiq_redis', 'redis://localhost:6379')
RedisClassy.redis = Redis.new(url: url, timeout: 10)
