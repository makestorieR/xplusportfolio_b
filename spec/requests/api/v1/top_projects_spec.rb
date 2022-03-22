


require 'rails_helper'

RSpec.describe "Api::V1::TopProjects", type: :request do
  include ApiDoc::V1::TopProjects::Api

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



  describe "#Index" do 

  	before do 
  		@top_projects_url = '/api/v1/top_projects'


  	end


  	context "when user is not authenticated" do 

  		it "returns http status unauthorized" do 
  			get @top_projects_url
  			expect(response).to have_http_status(:unauthorized)
  		end
  	end


  	# context "when user is authenticated" do 

  	# 	before do 
  	# 		get @top_projects_url, headers: @headers
  	# 		@json_data = JSON.parse(response.body)
  	# 	end


  	# 	it "returns proper json first data response" do 

  	# 		expect(@json_data.first).to include({
  	# 			'name' => "Ruby on rails"
  	# 		})
  	# 	end


  	# 	it "returns proper json last data response" do 

  	# 		expect(@json_data.last).to include({
  	# 			'name' => "Javascript"
  	# 		})
  	# 	end
  	# end

  end


 
  
end
