require 'rails_helper'


RSpec.describe "Anticipations", type: :routing do
    it "POST api/v1/notes routes to api/v1/notes#create" do
        expect(post '/api/v1/notes').to route_to('api/v1/notes#create')  
    end

    # it "GET api/v1/notes/todo-application routes to api/v1/notes#show" do
    #     expect(get '/api/v1/notes/todo-application').to route_to(controller: 'api/v1/notes', action: 'show', id: 'todo-application')  
    # end

    # it "PUT api/v1/notes/todo-application routes to api/v1/notes#update" do
    #     expect(put '/api/v1/notes/todo-application').to route_to(controller: 'api/v1/notes', action: 'update', id: 'todo-application')  
    # end

    # it "GET api/v1/projects/todo-application/notes routes to api/v1/notes#note_index" do
    #     expect(get '/api/v1/notes/todo-application/notes').to route_to(controller: 'api/v1/notes', action: 'subscribers', id: 'todo-application')
    # end


    

end
