require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  include ApiDoc::V1::Users::Api

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

  describe "GET /index" do
    include ApiDoc::V1::Users::Index

    before do 
      create_list :user, 20
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/users'
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "page params exists" do

      before do 
        
        get '/api/v1/users', params: {page: 2}, headers: @headers
        
        @json_data = JSON.parse(response.body)
      end

      it "returns proper length of the list of users" do
        expect(@json_data.length).to eq(10)
      end
  
      
    end


    context "page params does not exists" do

      before do 
        get '/api/v1/users', headers: @headers
        
        @json_data = JSON.parse(response.body)
      end

      it "returns proper length of the list of users" do
      
        expect(@json_data.length).to eq(10)
      end
      
    end
      
    end
    
  end





  describe "GET /show" do
    include ApiDoc::V1::Users::Show

    subject { get '/api/v1/users/paul-mike', headers: @headers } 

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/users/paul-mike'
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated " do

      it "returns proper length of the list of users" do
        subject 
        @json_data = JSON.parse(response.body)
        expect(@json_data['user']).to include({
          'name' => 'paul mike',
          'slug' => 'paul-mike'
        })
      end
      
  
      
    end


    context "when user could not be found " do
      it "returns http status :not_found" do
        get '/api/v1/users/peter-packer', headers: @headers
        expect(response).to have_http_status(:not_found)
        
      end
      
    end
    

  end
end
