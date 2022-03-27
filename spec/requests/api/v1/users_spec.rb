require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  include ApiDoc::V1::Users::Api
  include ApiDoc::V1::Users::Projects

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
      
        expect(@json_data.length).to eq(9)
      end
      
    end
      
    end
    
  end



  describe "GET /update" do
    include ApiDoc::V1::Users::Update

    subject { put '/api/v1/users/paul-mike', headers: @headers,  params: {name: "john paul", github_url: 'github_url', avatar_url: 'avatar_url'} } 

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/users/paul-mike'
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated " do

      context "and user successfully updated their data" do
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
          
        end
      end

      context "and user failed to updated their data" do
        it "returns http status :ok" do
          put '/api/v1/users/paul-mike', headers: @headers,  params: {name: "", github_url: 'github_url', avatar_url: 'avatar_url'}
          expect(response).to have_http_status(:unprocessable_entity)
          
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


  describe "GET /project_index" do
    include ApiDoc::V1::Users::ProjectIndex

    before do 

      20.times do |n|
        create :project, user: @user
      end


      @project_url = '/api/v1/users/paul-mike/projects'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/users/peter-packer/projects', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user projects" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user projects" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end


  describe "GET /suggestion_index" do
    include ApiDoc::V1::Users::SuggestionIndex

    before do 
      project = create :project, user: @user
      20.times do |n|
        create :suggestion, user: @user, project: project
      end


      @project_url = '/api/v1/users/paul-mike/suggestions'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/users/peter-packer/suggestions', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user suggestions" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user suggestions" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end

  describe "GET /anticipation_index" do
    include ApiDoc::V1::Users::AnticipationIndex

    before do 
      anticipation_cover = create :anticipation_cover
      20.times do |n|
        create :anticipation, user: @user, anticipation_cover: anticipation_cover
      end

      @project_url = '/api/v1/users/paul-mike/anticipations'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/users/peter-packer/anticipations', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user anticipations" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user anticipations" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end


  describe "GET /follower_index" do
    include ApiDoc::V1::Users::FollowerIndex

    before do 
      
      20.times do |n|
        user = create :user
        user.follow(@user)
      end

      @project_url = '/api/v1/users/paul-mike/followers'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/users/peter-packer/followers', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user followers" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user followers" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end


  describe "GET /follower_index" do
    include ApiDoc::V1::Users::FollowingIndex

    before do 
      
      20.times do |n|
        user = create :user
        @user.follow(user)
      end

      @project_url = '/api/v1/users/paul-mike/followings'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          get '/api/v1/users/peter-packer/followings', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "page params exists" do

        before do 
          get @project_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user followings" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @project_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user followings" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end
    
  end



  describe "POST /up" do
    include ApiDoc::V1::Users::Up

    before do 
      
      @searched_user = create :user, name: "paul obi"

      @project_url = '/api/v1/users/paul-obi/followings'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do
          post '/api/v1/users/peter-packer/followings', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user starts to follow  user" do

       
        it "returns proper length of the list of user followings" do
          
          expect{post @project_url, headers: @headers}.to change{@user.following_users_count}.by(1) 
        end

        it "returns http status :ok" do
          post @project_url, headers: @headers
          expect(response).to have_http_status(:ok) 
        end

        
        
    
        
      end

      context "current user is already following  user" do

        before do 
          @user.follow @searched_user
        end

       
        it "returns proper length of the list of user followings" do
          
          expect{post @project_url, headers: @headers}.not_to change{@user.following_users_count}
        end

        it "returns http status code unprocessable entity" do
          post @project_url, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity) 
        end
    
        
      end


      
      
    end
    
  end



  describe "DELETE /down" do
    include ApiDoc::V1::Users::Down

    before do 
      
      @searched_user = create :user, name: "paul obi"

      @project_url = '/api/v1/users/paul-obi/followings'
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete @project_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "when user could not be found " do
        it "returns http status :not_found" do

          delete '/api/v1/users/peter-packer/followings', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user stops to follow  user" do

        before do  
          @user.follow @searched_user
        end

       
        it "returns proper length of the list of user followings" do
          
          expect{delete @project_url, headers: @headers}.to change{@user.following_users_count}.from(1).to(0) 
        end

        it "returns http status :ok" do
          delete @project_url, headers: @headers
          expect(response).to have_http_status(:ok) 
        end

      end


    end
    
  end




end
