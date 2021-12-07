require 'rails_helper'


RSpec.describe "Users", type: :routing do
    it "GET api/v1/users routes to api/v1/users" do
        expect(get '/api/v1/users').to route_to('api/v1/users#index')  
    end
    
end
