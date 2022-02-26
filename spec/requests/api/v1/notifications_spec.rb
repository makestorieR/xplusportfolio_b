require 'rails_helper'

RSpec.describe "Api::V1::Notifications", type: :request do
  include ApiDoc::V1::Notifications::Api

  before do 

    @user = create :user
      @user.confirm
      @login_url = '/api/v1/auth/sign_in'

      @user_params = {
        email: @user.email,
        password: @user.password
      }

     

      post @login_url, params: @user_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

  end


  describe "PUT /update" do
    include ApiDoc::V1::Notifications::Update
    before do 
      
        a_cover = create :anticipation_cover
        anticipation = create :anticipation, user: @user, anticipation_cover: a_cover
       create :notification, recipient: @user, params: {anticipation: anticipation}
       create :notification, recipient: @user, id: 3, params: {anticipation: anticipation}

  
       @notifications_update_url = '/api/v1/notifications/3'
      
     
    end



    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        put @notifications_update_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do

      

      context "notification was found" do 
        it "succesfully updates the notification read status" do 
          put @notifications_update_url, headers: @headers
          expect(response).to have_http_status(:ok)
        end

      end

      context "notification could not be found" do 
        it "succesfully updates the notification read status" do 
          put '/api/v1/notifications/13', headers: @headers
          expect(response).to have_http_status(:not_found)
        end
      end

    end

end




  describe "GET /index" do
    include ApiDoc::V1::Notifications::Index
    before do 
     @notifications_url = '/api/v1/notifications'

      
     
    end



    context "when user is not authenticated" do
      it "returns http status :unauthorized" do
        get @notifications_url
        
        expect(response).to have_http_status(:unauthorized) 
      end
      
    end

    context "when user is authenticated and " do


      before do 
        a_cover = create :anticipation_cover
        anticipation = create :anticipation, user: @user, anticipation_cover: a_cover
        20.times do |n|
          create :notification, recipient: @user, params: {anticipation: anticipation}
        end

        

      end

      

      context "page params exists" do

        before do 
          get @notifications_url, params: {page: 2}, headers: @headers
          
          @json_data = JSON.parse(response.body)
          
        end

        it "returns proper length of the list of user notifications" do
          
          expect(@json_data.length).to eq(10)
        end
    
        
      end


      context "page params does not exists" do

        before do 
          get @notifications_url, headers: @headers
          
          @json_data = JSON.parse(response.body)
        end

        it "returns proper length of the list of user notifications" do
        
          expect(@json_data.length).to eq(10)
        end
        
      end
      
    end




  end



end
