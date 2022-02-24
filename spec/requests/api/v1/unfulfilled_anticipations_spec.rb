require 'rails_helper'


require 'rails_helper'

RSpec.describe "Api::V1::UnfulfilledAnticipations", type: :request do

  include ApiDoc::V1::UnfulfilledAnticipations::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @anticipation_url = '/api/v1/unfulfilled_anticipations'

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


  describe "GET /index" do
   	
   	include ApiDoc::V1::UnfulfilledAnticipations::Index


   	before do 

   	  project1 = create :project, title: "A Movie App", user: @user

      cover = create :anticipation_cover, id: 4
      create :anticipation,  body: "A Todo App", user: @user, anticipation_cover: cover, due_date: Date.tomorrow
      create :anticipation,  body: "A Rider  App", user: @user, anticipation_cover: cover
     
      create :anticipation,  body: "A gmail App", user: @user, anticipation_cover: cover
       create :anticipation,  body: "creating a A Movie App", user: @user, anticipation_cover: cover, project: project1
      

   	end


   	context "when user is not authenticated" do 

  		it "returns http status unauthorized" do 
  			get '/api/v1/unfulfilled_anticipations' 
   			expect(response).to have_http_status(:unauthorized)
  		end
  	end

  	context "when user is authenticated" do 

  		before do 
  			get '/api/v1/unfulfilled_anticipations', headers: @headers 
  			@json_data = JSON.parse(response.body)


  		end

  		it "return proper first json data response" do 
  			
  			expect(@json_data.first).to include({
  				'body' => "A Todo App",

  			})
  		end

  		it "return proper last json data response" do 

  			expect(@json_data.last).to include({
  				'body' => "A gmail App",
  				
  			})
  		end
  	end
    


  end



end
