require 'rails_helper'

RSpec.describe "Api::V1::Suggestions", type: :request do
  include ApiDoc::V1::Suggestions::Api

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


  describe "POST /create" do

    include ApiDoc::V1::Suggestions::Create 

    before do 

      @searched_user = create :user, name: "paul obi"
      @project = create :project, id: 3, title: "todo application", user: @searched_user, description: "A real world todo application"
      create :project, id: 5, title: "space ship app", user: @user, description: "a space ship application"


      @suggestion_url = '/api/v1/suggestions'
      @suggestion_params = {

        suggestion: {
          content: "work on the login feature, its kinda wacky.",
          project_id: 3
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post '/api/v1/suggestions/', params: @suggestion_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "new suggestion is created" do
        subject { post @suggestion_url, params: @suggestion_params, headers: @headers } 

        it "increment Suggestion.count by 1" do
          expect{subject}.to change{Suggestion.count}.by(1)  
        end

        it "returns http status :created" do
          subject
          expect(response).to have_http_status(:created)
        end
        
        
      end

      context "project belongs to user" do

        it "do not increment Suggestion.count " do
          expect{
            post @suggestion_url, params: {suggestion: {content: "work on the login feature, its kinda wacky.", project_id: 5}}, headers: @headers
          }.to_not change{Suggestion.count}  
        end

        it "returns http status :unprocessable_entity" do
          post @suggestion_url, params: {suggestion: {content: "work on the login feature, its kinda wacky.", project_id: 5}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end





        
      end
      

      context "suggestion failed to be created" do
        it "do not increment Suggestion.count " do
          expect{subject}.to_not change{Suggestion.count}  
        end

        it "returns http status :unprocessable_entity" do
          post @suggestion_url, params: {suggestion: {content: "", project_id: 3}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
      
    end
  
  end





  describe "PUT /update" do

    include ApiDoc::V1::Suggestions::Update 

    before do 

      @searched_user = create :user, name: "paul obi"
      @project = create :project, id: 3, title: "todo application", user: @searched_user, description: "A real world todo application"
      
      create :suggestion, id: 7, content: "work on login ", project: @project, user: @searched_user
      create :suggestion, id: 12, content: "fix the padding on the button nav", project: @project, user: @user



      @suggestion_url = '/api/v1/suggestions/7'
      
      @suggestion_params = {

        suggestion: {
          content: "work on the login feature, its kinda wacky."
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/suggestions/9', params: @suggestion_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end



    context "when user is authenticated and" do

      context "suggestion is updated" do
        subject { put @suggestion_url, params: @suggestion_params, headers: @headers } 

        it "returns http status :updated" do
          subject
          expect(response).to have_http_status(:ok)
        end
        
        
      end

      context "suggestion failed to be updated" do
        
        it "returns http status :unprocessable_entity" do
          put @suggestion_url, params: {suggestion: {content: ""}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end


      # context "when the user updating the suggestion done attribute is the creator" do

      #   it "returns http status :unprocessable entity" do
      #     put '/api/v1/suggestions/12', params: {suggestion: {content: "fix the padding on the button nav", done: true}}, headers: @headers
      #     expect(response).to have_http_status(:unprocessable_entity)
      #   end
        
        
      # end


      context "there should be no done attribute in the suggestion params when trying to update suggestion" do
        it "returns http status unprocessable_entity" do
          put '/api/v1/suggestions/7', params: {suggestion: {content: "fix the padding on the button nav", done: true}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)  
        end
        
      end
      
      

      context "suggestion was not found" do
        
        it "returns http status :not_found" do
          put '/api/v1/suggestions/9', params: {suggestion: {content: ""}}, headers: @headers
          expect(response).to have_http_status(:not_found)
        end
      
      end



      
    end
  
  end




  describe "PUT /mark_as_done" do

    include ApiDoc::V1::Suggestions::MarkAsDone 

    before do 

      @searched_user = create :user, name: "paul obi"
      @project = create :project, id: 3, title: "todo application", user: @searched_user, description: "A real world todo application"
      
      create :suggestion, id: 7, content: "work on login ", project: @project, user: @searched_user
      create :suggestion, id: 12, content: "fix the padding on the button nav", project: @project, user: @user



      @suggestion_url = '/api/v1/suggestions/7/complete'
      
     
    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/suggestions/9/complete'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end



    context "when user is authenticated and" do

      context "suggestion is updated" do
        subject { put @suggestion_url, headers: @headers } 

        it "returns http status :updated" do
          subject
          
          expect(response).to have_http_status(:ok)
        end

      end

     
      context "when the user updating the suggestion done attribute is the creator" do

        it "returns http status :unprocessable entity" do
          put '/api/v1/suggestions/12/complete', headers: @headers
          expect(response).to have_http_status(:unauthorized)
        end
        
        
      end

      
      

      context "suggestion was not found" do
        
        it "returns http status :not_found" do
          put '/api/v1/suggestions/9/complete', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
      
      end



      
    end
  
  end


  # describe "PUT /mark_as_done" do

  #   include ApiDoc::V1::Suggestions::Index 

  #   before do 

  #     @searched_user = create :user, name: "paul obi"
  #     @project = create :project, id: 3, title: "todo application", user: @searched_user, description: "A real world todo application"
      
  #     create :suggestion, id: 7, content: "work on login ", project: @project, user: @searched_user
  #     create :suggestion, id: 12, content: "fix the padding on the button nav", project: @project, user: @user



  #     @suggestion_url = '/api/v1/suggestions/'
      
     
  #   end

  #   context "when user is not authenticated" do
  #     it "returns http status :unauthorized" do
  #       put '/api/v1/suggestions/9/complete'
  #       expect(response).to have_http_status(:unauthorized)  
  #     end
      
  #   end



  #   context "when user is authenticated and" do

  #     context "suggestion is updated" do
  #       subject { put @suggestion_url, headers: @headers } 

  #       it "returns http status :updated" do
  #         subject
          
  #         expect(response).to have_http_status(:ok)
  #       end

  #     end

     
  #     context "when the user updating the suggestion done attribute is the creator" do

  #       it "returns http status :unprocessable entity" do
  #         put '/api/v1/suggestions/12/complete', headers: @headers
  #         expect(response).to have_http_status(:unauthorized)
  #       end
        
        
  #     end

      
      

  #     context "suggestion was not found" do
        
  #       it "returns http status :not_found" do
  #         put '/api/v1/suggestions/9/complete', headers: @headers
  #         expect(response).to have_http_status(:not_found)
  #       end
      
  #     end



      
  #   end
  
  # end


  
end
