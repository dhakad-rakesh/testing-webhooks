
url = ENV.fetch('ODD_STORE_URL', 'redis://localhost:6379' )
REDIS = Redis.new(url: url, timeout: 10)
# TODO: Use the right cache invalidation strategy
