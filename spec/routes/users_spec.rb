require 'rails_helper'


RSpec.describe "Users", type: :routing do
    it "GET api/v1/users routes to api/v1/users#index" do
        expect(get '/api/v1/users').to route_to('api/v1/users#index')  
    end

    it "GET api/v1/users/john-doe routes to api/v1/users#show" do
        expect(get '/api/v1/users/john-doe').to route_to(controller: 'api/v1/users', action: 'show', id: 'john-doe')  
    end

    
    
end
