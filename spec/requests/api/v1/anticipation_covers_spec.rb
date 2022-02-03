require 'rails_helper'

RSpec.describe "Api::V1::AnticipationCovers", type: :request do
	include ApiDoc::V1::AnticipationCovers::Api
  before do 

    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @anticipation_cover_url = '/api/v1/anticipation_covers'

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


  describe "#Index" do 


  	before do 
  		create :anticipation_cover, text_color: "#3usfhs", image: "kbkbkb"
  		create :anticipation_cover, text_color: "#sfs33", image: "sdfosfdsf"
  		create :anticipation_cover, text_color: "#3usfhs", image: "sdfosfdsf"
  		create :anticipation_cover, text_color: "#sfs333", image: "sdfosfdsf"
  		create :anticipation_cover, text_color: "#765655", image: "sdfosfdsf"


  	end


  	context "when user is not authenticated" do 

  		it "returns http status not_authorized" do 
  			get @anticipation_cover_url
       		 expect(response).to have_http_status(:unauthorized) 
  		end
  	end

  	context "when user is authenticated" do 

  		before do 

  			get @anticipation_cover_url, headers: @headers
  			@json_data = JSON.parse(response.body)
  		end



  		it "return proper first json response " do 
	  		expect(@json_data.first).to include({
	  			'text_color' => '#3usfhs',
	  			'image' => 'kbkbkb'
	  		})

  		end

  		it "return proper last json response " do 
	  		expect(@json_data.last).to include({
	  			'text_color' => '#765655',
	  			'image' => 'sdfosfdsf'
	  		})

  		end
  	end

  end





end
