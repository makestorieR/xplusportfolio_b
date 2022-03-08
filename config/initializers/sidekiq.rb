

#  if Rails.env == "production" ? 

#   Sidekiq.configure_client do |config|
#     config.redis = { url: ENV.fetch('REDISTOGO_URL') }
#   end
  
#   Sidekiq.configure_server do |config|
#     config.redis = { url: ENV.fetch('REDISTOGO_URL') }
#   end
# else 

#     Sidekiq.configure_client do |config|
#         config.redis = { url: ENV['REDIS_PROVIDER'] }
#       end
    
#     Sidekiq.configure_server do |config|
#       config.redis = { url: ENV['REDIS_PROVIDER'] }
#     end


# end
  


Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDISCLOUD_URL'), size: 1, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDISCLOUD_URL'), size: 12, network_timeout: 5 }
end