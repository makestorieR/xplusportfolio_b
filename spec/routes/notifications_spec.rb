require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "GET api/v1/notifications routes to api/v1/notifications#index" do
        expect(get '/api/v1/notifications').to route_to('api/v1/notifications#index')  
    end

end
