# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.production?
            
        origins 'https://xplusportfolio.herokuapp.com'
    else
        origins 'localhost:3000'

    end

    resource '*',
      headers: :any,
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end


end




#  if Rails.env.production? 

#     Rails.application.config.middleware.insert_before 0, Rack::Cors do
#       allow do
        
#         origins 'localhost:3000'

#         resource '*',
#           headers: :any,
#           expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
#           methods: [:get, :post, :put, :patch, :delete, :options, :head]
#       end


#     end

# else 

#   Rails.application.config.middleware.insert_before 0, Rack::Cors do
#       allow do
        
#         origins 'localhost:3000'

#         resource '*',
#           headers: :any,
#           expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
#           methods: [:get, :post, :put, :patch, :delete, :options, :head]
#       end


#     end


# end


