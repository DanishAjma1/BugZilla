Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379/0" } # Adjust according to your Redis setup
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/0" }
end
