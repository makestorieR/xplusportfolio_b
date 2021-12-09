require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "POST api/v1/suggestions routes to api/v1/suggestions#create" do
        expect(post '/api/v1/suggestions').to route_to('api/v1/suggestions#create')  
    end

    it "PUT api/v1/suggestions/todo-application routes to api/v1/suggestions#update" do
        expect(put '/api/v1/suggestions/todo-application').to route_to(controller: 'api/v1/suggestions', action: 'update', id: 'todo-application')  
    end

end
