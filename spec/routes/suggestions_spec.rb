require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "POST api/v1/suggestions routes to api/v1/suggestions#create" do
        expect(post '/api/v1/suggestions').to route_to('api/v1/suggestions#create')  
    end

    it "PUT api/v1/suggestions/4 routes to api/v1/suggestions#update" do
        expect(put '/api/v1/suggestions/4').to route_to(controller: 'api/v1/suggestions', action: 'update', id: '4')  
    end

    it "PUT api/v1/suggestions/4/complete routes to api/v1/suggestions#mark_as_done" do
        expect(put '/api/v1/suggestions/4/complete').to route_to(controller: 'api/v1/suggestions', action: 'mark_as_done', suggestion_id: '4')  
    end

    it "GET api/v1/suggestions/ routes to api/v1/suggestions#index" do 

    	expect(get '/api/v1/suggestions/').to route_to('api/v1/suggestions#index')
    end 
    

end
