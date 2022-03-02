require 'rails_helper'

RSpec.describe "Api::V1::Activities", type: :request do


  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @anticipation_url = '/api/v1/anticipations'

    @login_params = {
      email: @user.email,
      password: @user.password 
    }

    post @login_url, params: @login_params 

    @headers = {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid']
    }

  end




	describe "GET api/v1/all_activities" do 


	   	context "when user is not authenticated" do
	      it "returns http status :unauthorized" do
	        get '/api/v1/all_activities/'
	        expect(response).to have_http_status(:unauthorized)  
	      end
	      
	    end




	end

    describe "GET api/v1/friends_activities" do 


	   	context "when user is not authenticated" do
	      it "returns http status :unauthorized" do
	        get '/api/v1/friends_activities/'
	        expect(response).to have_http_status(:unauthorized)  
	      end
	      
	    end




    end

    describe "GET api/v1/user_activities" do 


	   	context "when user is not authenticated" do
	      it "returns http status :unauthorized" do
	        get '/api/v1/user_activities/'
	        expect(response).to have_http_status(:unauthorized)  
	      end
	      
	    end


	    context "when user is authenticated " do 

	    	context "when user could not be found " do 

	    		it "returns http status :not_found" do 

	    			get '/api/v1/user_activities', headers: @headers, params: {id: '35'}

	    			expect(response).to have_http_status(:not_found)

	    		end	


	    	end
	    end




    end






end
