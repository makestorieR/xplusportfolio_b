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

    @project = create :project, id: 34, user: @user

  end


  describe "POST /create" do
    include ApiDoc::V1::Notes::Create 

    before do 
      
      @note_params = {

        note: {
         
         content: "i really like the way the note is being shown and how it can be portraiyed", 
         project_id: 34
  
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

      context "new note is created" do
        subject { post @note_url, params: @note_params, headers: @headers } 

        it "increment Note.count by 1" do
          expect{subject}.to change{Note.count}.by(1)  
        end

        it "returns http status :created" do
          subject
          expect(response).to have_http_status(:created)
        end

        # it "matches with performed job" do
        #   ActiveJob::Base.queue_adapter = :test
        #   ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
          
        #   expect {
        #     subject
        #   }.to have_performed_job(NewNoteJob)
        # end
        
        
      end

      context "note failed to be created" do
        it "do not increment Note.count " do
          expect{subject}.to_not change{Note.count}  
        end

        it "returns http status :unprocessable_entity" do
          post @note_url, params: {note: {content: "this is a really like application, what i like about the project is the fact that users are using the note part very well"}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
      
     end
  
  end





   describe "GET /show" do
    include ApiDoc::V1::Notes::Show 

    before do 

      create :note, id: 12, user: @user, project: @project, content:  'i really like the way the note is being shown and how it can be portraiyed'
    end

    

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/notes/12'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "about to get note" do
        subject { get '/api/v1/notes/12', headers: @headers } 

       

        it "returns http status ok" do
          subject
          expect(response).to have_http_status(:ok)
        end

        it "returns proper json response of the note" do 

          subject 

          json_data = JSON.parse(response.body)

          expect(json_data['note']).to include({
            'content' => 'i really like the way the note is being shown and how it can be portraiyed'
          })

        end
        
      end

      context "note could not be found" do
      
        it "returns http status not_found " do 

          get '/api/v1/notes/132', headers: @headers

          expect(response).to have_http_status(:not_found)
        end
      
      end
      
     end
  
  end



   describe "GET /update" do
    include ApiDoc::V1::Notes::Update 

    before do 
      @note_params = {
        note: {
          content: 'new note like to be shown'
        }
      }
      create :note, id: 12, user: @user, project: @project, content:  'i really like the way the note is being shown and how it can be portraiyed'
    end

    

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/notes/12'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "note is being updated " do
        subject { put '/api/v1/notes/12', params: @note_params, headers: @headers } 

       

        it "returns http status ok" do
          subject
          expect(response).to have_http_status(:ok)
        end

        it "changes content of the note " do 
          subject
          note = Note.find(12)

          expect(note.content).to eq('new note like to be shown')


        end

        
      end


      context "when not failed to be updated " do 


        it "returns https status code unprocessable_entity" do 
            put '/api/v1/notes/12', params: {note: {content: ''}}, headers: @headers
            expect(response).to have_http_status(:unprocessable_entity)

        end 
      end

      context "note could not be found" do
      
        it "returns http status not_found " do 

          put '/api/v1/notes/132', headers: @headers

          expect(response).to have_http_status(:not_found)
        end
      
      end
      
     end
  
  end




end
