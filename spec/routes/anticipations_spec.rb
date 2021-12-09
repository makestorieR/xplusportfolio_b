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




    it "POST api/v1/anticipations/todo-application/suscribers routes to api/v1/anticipations#suscribe" do
        expect(post 'api/v1/anticipations/todo-application/suscribers').to route_to(controller: 'api/v1/anticipations', action: 'suscribe', id: 'todo-application')  
    end

    it "DELETE api/v1/anticipations/todo-application/suscribers routes to api/v1/anticipations#unsuscribe" do
        expect(delete '/api/v1/anticipations/todo-application/suscribers').to route_to(controller: 'api/v1/anticipations', action: 'unsuscribe', id: 'todo-application')  
    end



    it "POST api/v1/anticipations/todo-application/likes routes to api/v1/anticipations#up" do
        expect(post '/api/v1/anticipations/todo-application/likes').to route_to(controller: 'api/v1/anticipations', action: 'up', id: 'todo-application')  
    end

    it "DELETE api/v1/anticipations/todo-application/likes routes to api/v1/anticipations#down" do
        expect(delete '/api/v1/anticipations/todo-application/likes').to route_to(controller: 'api/v1/anticipations', action: 'down', id: 'todo-application')  
    end

end
