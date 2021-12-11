require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "POST api/v1/web_push_notifications routes to api/v1/web_push_notifications#create" do
        expect(post '/api/v1/web_push_notifications').to route_to('api/v1/web_push_notifications#create')  
    end

end
