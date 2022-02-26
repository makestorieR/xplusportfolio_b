require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "GET api/v1/notifications routes to api/v1/notifications#index" do
        expect(get '/api/v1/notifications').to route_to('api/v1/notifications#index')  
    end


    it "PUT api/v1/notifications/3 routes to api/v1/notifications#mark_read" do 

    	expect(put '/api/v1/notifications/3').to route_to(controller: 'api/v1/notifications', id: '3', action: 'mark_read')

    end

end
