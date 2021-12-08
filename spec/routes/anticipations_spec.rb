require 'rails_helper'


RSpec.describe "Anticipations", type: :routing do
    it "POST api/v1/anticipations routes to api/v1/anticipations#create" do
        expect(post '/api/v1/anticipations').to route_to('api/v1/anticipations#create')  
    end

    it "GET api/v1/anticipations/todo-application routes to api/v1/anticipations#show" do
        expect(get '/api/v1/anticipations/todo-application').to route_to(controller: 'api/v1/anticipations', action: 'show', id: 'todo-application')  
    end

    it "PUT api/v1/anticipations/todo-application routes to api/v1/anticipations#update" do
        expect(put '/api/v1/anticipations/todo-application').to route_to(controller: 'api/v1/anticipations', action: 'update', id: 'todo-application')  
    end

   

end
