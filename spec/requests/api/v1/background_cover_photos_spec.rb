
require 'rails_helper'

RSpec.describe "Api::V1::BackgroundCoverPhotos", type: :request do


  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
   

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



  describe "#UPDATE" do 

  	context "when user is not authenticated" do 

  		it "returns http status code " do 

  			put '/api/v1/background_cover_photos'

  			expect(response).to have_http_status(:unauthorized)
  		end
  	end

  end



end

