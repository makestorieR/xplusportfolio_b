require 'rails_helper'


RSpec.describe "Search", type: :routing do
  
    it "GET api/v1/search routes to api/v1/search#index" do
        expect(get '/api/v1/search').to route_to(controller: 'api/v1/search', action: 'index')  
    end

end
