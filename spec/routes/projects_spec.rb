require 'rails_helper'


RSpec.describe "Projects", type: :routing do
    it "POST api/v1/projects routes to api/v1/projects#create" do
        expect(post '/api/v1/projects').to route_to('api/v1/projects#create')  
    end

    it "GET api/v1/projects/todo-application routes to api/v1/projects#show" do
        expect(get '/api/v1/projects/todo-application').to route_to(controller: 'api/v1/projects', action: 'show', id: 'todo-application')  
    end

    it "PUT api/v1/projects/todo-application routes to api/v1/projects#update" do
        expect(put '/api/v1/projects/todo-application').to route_to(controller: 'api/v1/projects', action: 'update', id: 'todo-application')  
    end

    it "DELETE api/v1/projects/todo-application routes to api/v1/projects#destroy" do
        expect(delete '/api/v1/projects/todo-application').to route_to(controller: 'api/v1/projects', action: 'destroy', id: 'todo-application')  
    end

end
