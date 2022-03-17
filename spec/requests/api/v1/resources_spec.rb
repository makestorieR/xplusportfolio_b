require 'rails_helper'

RSpec.describe "Api::V1::Resources", resource_type: :request do
  include ApiDoc::V1::Searchs::Api

  before do 

    @user = create :user
      @user.confirm
      @login_url = '/api/v1/auth/sign_in'

      @user_params = {
        email: @user.email,
        password: @user.password
      }

     

      post @login_url, params: @user_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

  end


  describe "GET /index" do
    include ApiDoc::V1::Resources::Index


    before do 

    	create :resource, resource_type: "community", title: "alc" 
    	create :resource, resource_type: "learning", title: "learning how to learn"
    	create :resource, resource_type: "community", title: "year one"
    	create :resource, resource_type: "job", title: "arc.dev"
    	create :resource, resource_type: "learning", title: "robs"
    end


    context "when user is not authenticated" do
    	
      it "returns http status :unauthorized" do
        get '/api/v1/resources'
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end


    context "when a user is authenticated" do 

    	


    	context "when resource_type params is that of community" do 


    		before do 

    			get '/api/v1/resources', params: {resource_type: 'community'}, headers: @headers 
    			@json_data = JSON.parse(response.body)
    		end

    		it "returns proper first json  data response " do 

	    		expect(@json_data.first).to include({
	    			'title' => 'alc'
	    		})

	    	end


	    	it "returns proper last json  data response " do 

	    		expect(@json_data.last).to include({
	    			'title' => 'year one'
	    		})

	    	end




    	end


    	context "when resource_type params is that of learning" do 


    		before do 

    			get '/api/v1/resources', params: {resource_type: 'learning'}, headers: @headers 
    			@json_data = JSON.parse(response.body)
    		end

    		it "returns proper first json  data response " do 

	    		expect(@json_data.first).to include({
	    			'title' => 'learning how to learn'
	    		})

	    	end


	    	it "returns proper last json  data response " do 

	    		expect(@json_data.last).to include({
	    			'title' => 'robs'
	    		})

	    	end




    	end
    end 
    
  end

end
