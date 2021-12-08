require 'rails_helper'


RSpec.describe "Users", type: :routing do
    it "GET api/v1/users routes to api/v1/users#index" do
        expect(get '/api/v1/users').to route_to('api/v1/users#index')  
    end

    it "GET api/v1/users/john-doe routes to api/v1/users#show" do
        expect(get '/api/v1/users/john-doe').to route_to(controller: 'api/v1/users', action: 'show', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/projects routes to api/v1/users#projects_index" do
        expect(get '/api/v1/users/john-doe/projects').to route_to(controller: 'api/v1/users', action: 'projects_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/suggestions routes to api/v1/users#suggestions_index" do
        expect(get '/api/v1/users/john-doe/suggestions').to route_to(controller: 'api/v1/users', action: 'suggestions_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/anticipations routes to api/v1/users#anticipations_index" do
        expect(get '/api/v1/users/john-doe/anticipations').to route_to(controller: 'api/v1/users', action: 'anticipations_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/followers routes to api/v1/users#followers_index" do
        expect(get '/api/v1/users/john-doe/followers').to route_to(controller: 'api/v1/users', action: 'followers_index', id: 'john-doe')  
    end

    it "GET api/v1/users/john-doe/following routes to api/v1/users#following_index" do
        expect(get '/api/v1/users/john-doe/following').to route_to(controller: 'api/v1/users', action: 'following_index', id: 'john-doe')  
    end

    

 
    
end
