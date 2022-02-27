require 'rails_helper'
RSpec.describe "Api::V1::Search", type: :request do
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
    include ApiDoc::V1::Searchs::Index


    context "when user is not authenticated" do
    	
      it "returns http status :unauthorized" do
        get '/api/v1/search'
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end
    
  end



end

