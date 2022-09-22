
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['sidekiq_redis'], db: Figaro.env.sidekiq_redis_db.to_i }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['sidekiq_redis'], db: Figaro.env.sidekiq_redis_db.to_i }
end

Sidekiq::Logging.logger.level = Logger::WARN if Rails.env != 'development'
