require 'rails_helper'

RSpec.describe "Api::V1::Notes", type: :request do
  include ApiDoc::V1::Notes::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @note_url = '/api/v1/mark_note'

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




   describe "GET /update" do
    include ApiDoc::V1::Notes::Update 

    before do 
     
      create :note, id: 12, user: @user, project: @project, content:  'i really like the way the note is being shown and how it can be portraiyed'
    end

    

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/mark_note/12'
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "note is being updated " do
        subject { put '/api/v1/mark_note/12', headers: @headers } 

       

        it "returns http status ok" do
          subject
          expect(response).to have_http_status(:ok)
        end

        it "changes content of the note " do 
          subject
          note = Note.find(12)

          expect(note.seen).to eq(true)


        end


      

      context "note could not be found" do
      
        it "returns http status not_found " do 

          put '/api/v1/mark_note/132', headers: @headers

          expect(response).to have_http_status(:not_found)
        end
      
      end
      
     end
  
  end




end
