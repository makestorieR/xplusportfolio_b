require 'rails_helper'

RSpec.describe "Api::V1::Notes", type: :request do
  include ApiDoc::V1::Notes::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @note_url = '/api/v1/notes'

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
    include ApiDoc::V1::Notes::Create 

    before do 
      
      @note_params = {

        note: {
         
         content: "i really like the way the note is being shown and how it can be portraiyed"
  
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post '/api/v1/notes/', params: @note_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

    #   context "new note is created" do
    #     subject { post @note_url, params: @note_params, headers: @headers } 

    #     it "increment Note.count by 1" do
    #       expect{subject}.to change{Note.count}.by(1)  
    #     end

    #     it "returns http status :created" do
    #       subject
    #       expect(response).to have_http_status(:created)
    #     end

    #     it "matches with performed job" do
    #       ActiveJob::Base.queue_adapter = :test
    #       ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
          
    #       expect {
    #         subject
    #       }.to have_performed_job(NewNoteJob)
    #     end
        
        
    #   end

    #   context "note failed to be created" do
    #     it "do not increment Note.count " do
    #       expect{subject}.to_not change{Note.count}  
    #     end

    #     it "returns http status :unprocessable_entity" do
    #       post @note_url, params: {note: {content: "this is a really like application, what i like about the project is the fact that users are using the note part very well"}}, headers: @headers
    #       expect(response).to have_http_status(:unprocessable_entity)
    #     end
      
    #   end
      
     end
  
  end




end
