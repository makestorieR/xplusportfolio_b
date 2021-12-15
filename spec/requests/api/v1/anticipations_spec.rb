require 'rails_helper'

RSpec.describe "Api::V1::Anticipations", type: :request do
  include ApiDoc::V1::Anticipations::Api

  before do 

    
    @login_url = '/api/v1/auth/sign_in'

    @user = create :user, email: "meller@gmail.com", password: "password", name: "paul mike"
    @user.confirm
    @anticipation_url = '/api/v1/anticipations'

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
    include ApiDoc::V1::Anticipations::Create 

    before do 

      create :anticipation_cover, id: 4
      
      @anticipation_params = {

        anticipation: {
          
          body: "A todo application that help people to keep track of all their activities",
          due_date: Date.today,
          
          anticipation_cover_id: 4
  
        }
        
      }

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post '/api/v1/anticipations/', params: @anticipation_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "new anticipation is created" do
        subject { post @anticipation_url, params: @anticipation_params, headers: @headers } 

        it "increment Anticipation.count by 1" do
          expect{subject}.to change{Anticipation.count}.by(1)  
        end

        it "returns http status :created" do
          subject
          expect(response).to have_http_status(:created)
        end

        it "matches with performed job" do
          ActiveJob::Base.queue_adapter = :test
          ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
          
          expect {
            subject
          }.to have_performed_job(NewAnticipationJob)
        end
        
        
      end

      context "anticipation failed to be created" do
        it "do not increment Anticipation.count " do
          expect{subject}.to_not change{Anticipation.count}  
        end

        it "returns http status :unprocessable_entity" do
          post @anticipation_url, params: {anticipation: {body: "", anticipation_cover_id: 4}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
      
    end
  
  end


  describe "PUT /update" do
    include ApiDoc::V1::Anticipations::Update 

    before do 
      
      @anticipation_params = {

        anticipation: {
          
          body: "A todo application that help people to keep track of all their activities"
  
        }
      } 

      cover = create :anticipation_cover, id: 4
      @anticipation = create :anticipation, slug: 'todo-application',  body: "A Todo App", user: @user, anticipation_cover: cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}"

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put '/api/v1/anticipations/todo-application', params: @anticipation_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "anticipation is updated" do
        subject { put @anticipation_url, params: @anticipation_params, headers: @headers } 

        
        it "returns http status :ok" do
          subject
          expect(response).to have_http_status(:ok)
        end
        
        
      end

      context "anticipation failed to be updated" do

        it "returns http status :unprocessable_entity" do
          put @anticipation_url, params: {anticipation: {body: "this is a todo application", due_date: nil}}, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end

      context "anticipation could not be found" do
        it "returns http status :not_found" do
          put '/api/v1/anticipations/todo', headers: @headers, params: @anticipation_params
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end


  

  describe "GET /show" do
    include ApiDoc::V1::Anticipations::Show 

    before do 
      user1 = create :user
      user2 = create :user
      cover = create :anticipation_cover, id: 4
      @anticipation = create :anticipation, slug: 'todo-application',  body: "A Todo App", user: @user, anticipation_cover: cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}"

      user1.follow(@anticipation)
      user2.follow(@anticipation)
      user1.likes @anticipation

    end

    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get '/api/v1/anticipations/todo-application', params: {page: 1}
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end

    context "when user is authenticated and" do

      context "anticipation is found" do
        subject { get @anticipation_url, headers: @headers, params: {page: 1} } 

        before do 
          subject
          @json_data = JSON.parse(response.body)
        end

        
        it "returns http status :ok" do
          
          expect(response).to have_http_status(:ok)
        end

        it "returns anticipation as json response" do
           
          expect(@json_data['anticipation']).to  include({
              'body' => 'A Todo App',
              'total_likes' => 1,
              'total_suscribers' =>  2
            })
          end

          it "returns proper length of anticipation suscribers as json response" do
            
              expect(@json_data['anticipation']['suscribers'].size).to  eq(2)
          end

        end


     

      context "anticipation could not be found" do
        it "returns http status :not_found" do
          get '/api/v1/anticipations/todo', headers: @headers, params: {page: 1}
          expect(response).to have_http_status(:not_found)
        end
        
      end
      
      
    end
  
  end



  describe "POST /suscribe" do
    include ApiDoc::V1::Anticipations::Suscribe

    before do 
      a_cover = create :anticipation_cover
      @searched_user = create :user, name: "paul obi"
      @anticipation = create :anticipation, body: "Working on a todo application", user: @searched_user, due_date: Date.today, anticipation_cover: a_cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}/suscribers"
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post @anticipation_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "anticipation could not be found " do
        it "returns http status :not_found" do
          post '/api/v1/anticipations/sdfsrdeds/suscribers', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user suscribe to an  anticipation" do

        before do 
          a_cover = create :anticipation_cover
         
          @anticipation = create :anticipation, body: "Working on a todo application", user: @user, due_date: Date.today, anticipation_cover: a_cover
          @new_anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}/suscribers"
        end


        it "increment anticipation suscribers" do
          
          expect{post @new_anticipation_url, headers: @headers}.to change{@anticipation.count_user_followers}.by(1) 
        end

        it "returns http status :ok" do
          post @new_anticipation_url, headers: @headers

          
          expect(response).to have_http_status(:ok) 
        end

      end

      context "when the user suscribing to an anticipation is the anticipation owner" do

        
        it "do not increment anticipation suscribers" do
          
          expect{post @anticipation_url, headers: @headers}.not_to change{@user.following_users_count}
        end

        it "returns http status code unprocessable entity" do
          post @anticipation_url, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity) 
        end
      end
      

      context "user has already suscribed to anticipation" do

        before do 
          @user.follow @anticipation
        end

       
        it "do not increment anticipation suscribers" do
          
          expect{post @anticipation_url, headers: @headers}.not_to change{@user.following_users_count}
        end

        it "returns http status code unprocessable entity" do
          post @anticipation_url, headers: @headers
          expect(response).to have_http_status(:unprocessable_entity) 
        end
    
        
      end

    end
    
  end



  describe "DELETE /unsuscrbe" do
    include ApiDoc::V1::Anticipations::Unsuscribe

    before do 
      a_cover = create :anticipation_cover
      @searched_user = create :user, name: "paul obi"
      @anticipation = create :anticipation, body: "Working on a todo application", user: @searched_user, due_date: Date.today, anticipation_cover: a_cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}/suscribers"
      @user.follow @anticipation
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete @anticipation_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "anticipation could not be found " do
        it "returns http status :not_found" do
          delete '/api/v1/anticipations/sdfsrdeds/suscribers', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      

      context "current user  unsuscribe to an  anticipation" do

        it "increment anticipation suscribers" do
          
          expect{delete @anticipation_url, headers: @headers}.to change{@anticipation.count_user_followers}.from(1).to(0)
        end

        it "returns http status :ok" do
          delete @anticipation_url, headers: @headers

          
          expect(response).to have_http_status(:ok) 
        end

      end

     
    end
    
  end


  describe "POST /up" do
    include ApiDoc::V1::Anticipations::Up

    before do 
      a_cover = create :anticipation_cover
      @searched_user = create :user, name: "paul obi"
      @anticipation = create :anticipation, body: "Working on a todo application", user: @searched_user, due_date: Date.today, anticipation_cover: a_cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}/likes"
      
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        post @anticipation_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "anticipation could not be found " do
        it "returns http status :not_found" do
          post '/api/v1/anticipations/sdfsrdeds/likes', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      
      context "current user  likes an  anticipation" do

        it "increment anticipation likes" do
          
          expect{post @anticipation_url, headers: @headers}.to change{@anticipation.get_likes.size}.by(1)
        end

        it "returns http status :ok" do
          post @anticipation_url, headers: @headers

          
          
          expect(response).to have_http_status(:ok) 
        end

      end
 
    end
    
  end



  describe "DELETE /down" do
    include ApiDoc::V1::Anticipations::Down

    before do 
      a_cover = create :anticipation_cover
      @searched_user = create :user, name: "paul obi"
      @anticipation = create :anticipation, body: "Working on a todo application", user: @searched_user, due_date: Date.today, anticipation_cover: a_cover
      @anticipation_url = "/api/v1/anticipations/#{@anticipation.slug}/likes"
      @user.likes @anticipation
    end
    
    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        delete @anticipation_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      context "anticipation could not be found " do
        it "returns http status :not_found" do
          delete '/api/v1/anticipations/sdfsrdeds/likes', headers: @headers
          expect(response).to have_http_status(:not_found)
          
        end
        
      end
      
      context "current user  unlikes an  anticipation" do

        it "decrement anticipation likes" do
          
          expect{delete @anticipation_url, headers: @headers}.to change{@anticipation.get_likes.size}.from(1).to(0)
        end

        it "returns http status :ok" do
          delete @anticipation_url, headers: @headers
          expect(response).to have_http_status(:ok) 
        end

      end
 
    end
    
  end
end
