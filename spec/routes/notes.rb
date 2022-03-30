require 'rails_helper'


RSpec.describe "Anticipations", type: :routing do
    it "POST api/v1/notes routes to api/v1/notes#create" do
        expect(post '/api/v1/notes').to route_to('api/v1/notes#create')  
    end

    it "GET api/v1/notes/4 routes to api/v1/notes#show" do
        expect(get '/api/v1/notes/4').to route_to(controller: 'api/v1/notes', action: 'show', id: '4')  
    end

    it "PUT api/v1/notes/4 routes to api/v1/notes#update" do
        expect(put '/api/v1/notes/4').to route_to(controller: 'api/v1/notes', action: 'update', id: '4')  
    end

    it "PUT api/v1/mark_note/4 routes to api/v1/mark_note#update" do
        expect(put '/api/v1/mark_note/4').to route_to(controller: 'api/v1/mark_note', action: 'update', id: '4')  
    end



    # it "GET api/v1/projects/4/notes routes to api/v1/notes#note_index" do
    #     expect(get '/api/v1/notes/4/notes').to route_to(controller: 'api/v1/notes', action: 'subscribers', id: '4')
    # end

end
