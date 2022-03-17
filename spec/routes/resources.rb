require 'rails_helper'


RSpec.describe "Resources", type: :routing do


    it "GET api/v1/resources/ routes to api/v1/resources#index" do
        expect(get '/api/v1/resources').to route_to('api/v1/resources#index')  
    end

    
end