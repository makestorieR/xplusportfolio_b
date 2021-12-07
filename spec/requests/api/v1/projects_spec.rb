require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  include ApiDoc::V1::Projects::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @project_url = '/api/v1/projects'

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


  describe "POST /create" do
    include ApiDoc::V1::Projects::Create 

    before do 
      
      @project_params = {

        project: {
          title: "Todo Application",
          description: "A todo application that help people to keep track of all their activities"
  
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post '/api/v1/projects/', params: @project_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "new project is created" do
        subject { post @project_url, params: @project_params, headers: @headers } 

        it "increment Project.count by 1" do
          expect{subject}.to change{Project.count}.by(1)  
        end

        it "returns http status :created" do
          subject
          expect(response).to have_http_status(:created)
        end
        
        
      end

      context "project failed to be created" do
        it "do not increment Project.count " do
          expect{subject}.to_not change{Project.count}  
        end

        it "returns http status :unprocessable_entity" do
          post @project_url, params: {project: {title: "", description: "this is a todo application"}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
      
    end
  
  end


  describe "POST /update" do
    include ApiDoc::V1::Projects::Update 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      @project_params = {

        project: {
          title: "Todo Application",
          description: "A todo application that help people to keep track of all their activities"
  
        }
        
      }


      create :project, title: "Todo Application", description: "A Todo App", user: @user


    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/projects/todo-application', params: @project_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is updated" do
        subject { put @project_url, params: @project_params, headers: @headers } 

        
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
        end
        
        
      end

      context "project failed to be updated" do

        it "returns http status :unprocessable_entity" do
          put @project_url, params: {project: {title: "", description: "this is a todo application"}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          put '/api/v1/projects/todo', headers: @headers, params: @project_params
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  describe "DELETE /destroy" do
    include ApiDoc::V1::Projects::Destroy 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      
      create :project, title: "Todo Application", description: "A Todo App", user: @user

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete '/api/v1/projects/todo-application'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is deleted" do
        subject { delete @project_url, headers: @headers } 

        
        it "returns http status :no_content" do
          subject
          expect(response).to have_http_status(:no_content)
        end

        it "return nil project" do
          subject
          expect(Project.friendly.find_by_slug('todo-application')).to eq(nil)  
          
        end 
        
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          delete '/api/v1/projects/todo', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  describe "GET /show" do
    include ApiDoc::V1::Projects::Show 

    before do 
      @project_url = '/api/v1/projects/todo-application'
      
      create :project, title: "Todo Application", description: "A Todo App", user: @user

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/projects/todo-application'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "project is found" do
        subject { get @project_url, headers: @headers } 

        
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
        end

        it "returns project as json response" do
          get '/api/v1/projects/todo-application', headers: @headers
          json_data = JSON.parse(response.body)

          
          expect(json_data['project']).to  include({
            'title' => 'Todo Application',
            'description' => 'A Todo App'
          })
        end
        
        
      end

      context "project could not be found" do
        it "returns http status :not_found" do
          get '/api/v1/projects/todo', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end
end
