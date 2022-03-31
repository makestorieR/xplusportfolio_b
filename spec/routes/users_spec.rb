require 'rails_helper'


RSpec.describe "Users", type: :routing do
    it "GET api/v1/users routes to api/v1/users#index" do
        expect(get '/api/v1/users').to route_to('api/v1/users#index')  
    end

    it "GET api/v1/users/john-doe routes to api/v1/users#show" do
        expect(get '/api/v1/users/john-doe').to route_to(controller: 'api/v1/users', action: 'show', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/projects routes to api/v1/users#projects_index" do
        expect(get '/api/v1/users/john-doe/projects').to route_to(controller: 'api/v1/users', action: 'project_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/suggestions routes to api/v1/users#suggestions_index" do
        expect(get '/api/v1/users/john-doe/suggestions').to route_to(controller: 'api/v1/users', action: 'suggestion_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/anticipations routes to api/v1/users#anticipations_index" do
        expect(get '/api/v1/users/john-doe/anticipations').to route_to(controller: 'api/v1/users', action: 'anticipation_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/followers routes to api/v1/users#followers_index" do
        expect(get '/api/v1/users/john-doe/followers').to route_to(controller: 'api/v1/users', action: 'follower_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/followings routes to api/v1/users#followings_index" do
        expect(get '/api/v1/users/john-doe/followings').to route_to(controller: 'api/v1/users', action: 'following_index', id: 'john-doe')  
    end

    it "POST api/v1/users/john-doe/followings routes to api/v1/users#up" do
        expect(post '/api/v1/users/john-doe/followings').to route_to(controller: 'api/v1/users', action: 'up', id: 'john-doe')  
    end

     it "PUT api/v1/users/john-doe routes to api/v1/users#update" do
        expect(put '/api/v1/users/john-doe').to route_to(controller: 'api/v1/users', action: 'update', id: 'john-doe')  
    end

    it "DELETE api/v1/users/john-doe/followings routes to api/v1/users#down" do
        expect(delete '/api/v1/users/john-doe/followings').to route_to(controller: 'api/v1/users', action: 'down', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/notes routes to api/v1/users#note_index" do
        expect(get '/api/v1/users/john-doe/notes').to route_to(controller: 'api/v1/users', action: 'note_index', id: 'john-doe')  
    end

end
