require 'rails_helper'

RSpec.describe "Api::V1::WebPushNotifications", type: :request do
  describe "POST /create" do

    before do 
      @user = create :user
      @user.confirm
  


      @login_url = '/api/v1/auth/sign_in'

  
      @user_params = {
        email: @user.email,
        password: @user.password
      }

      @web_push_notifications_url = '/api/v1/web_push_notifications'

      @web_push_notifications_params =  {subscription: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGsfsfsnj53WgPegl9OUImd46JNsKggeM0IwPDsdfsB2X__kWiGrHP9B5I1fssLgg07i8ZiKs",auth: "q878hjyfhcAppD0LjPVJfSuw"}}}

      post @login_url, params: @user_params
        
        @headers = {
          'access-token' => response.headers['access-token'],
          'client' => response.headers['client'],
          'uid' => response.headers['uid']
        }

      
     
    end


    
    context "when user is not authenticated" do
      it "return http status unauthorized" do
        
        post '/api/v1/web_push_notifications', params: @web_push_notifications_params
        expect(response).to have_http_status(:unauthorized)  
      end
      
    end


    context "when user is authenticated" do

      subject {  post '/api/v1/web_push_notifications', 
        params: @web_push_notifications_params,
        headers: @headers
      } 

      context "and new web_push_notifications has been created " do 

        it "increment web_push_notification count by 1" do
            expect{subject}.to change{WebPushNotification.count}.by(1)
          end

          it "returns http status created" do
            subject
            
            expect(response).to have_http_status(:created)
            
          end
          
      end


      context "webpushnofication failed to be created " do
        it "returns http status unprocessable_entity" do
          post '/api/v1/web_push_notifications', headers: @headers, params: {subscription: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "BD2G1LyFRbbs-h0IqjfveymT6gvGsfsfsnj53WgPegl9OUImd46JNsKggeM0IwPDsdfsB2X__kWiGrHP9B5I1fssLgg07i8ZiKs",auth: ""}}}

      

      
          
          expect(response).to have_http_status(:unprocessable_entity)
          
        end
      end
      
      
    end
    

    


    context "when webpush notification already exist" do
      subject {  post '/api/v1/web_push_notifications', 
        params: {subscription: {endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PODQmuTBXcF-Y63qOvgeGja", expirationTime:nil ,keys:{p256dh: "h0IqjfvsdfsfwfffsfeymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs",auth: "qp9nluZcAfs4sdfsdfrefefsppD0LjPVJfSuw"}}},
        headers: @headers
      } 

      before do 
        create :web_push_notification, user: @user, endpoint: "https://fcm.googleapis.com/fcm/send/dlhl7mv25oM:APA91bHlCX8R5DNiq694bbjJOcAiSAHq61JtdLoaReFOGVRWOlpJbQWn9py9z8Fq5eq4iGJjDBF4VE7SG1JzJHZXJEqzz_Bvf7N542h73QWbIIouIn583PsfsfsfsfsfsfsfsfvgeGja", auth_key: "qp9nluZcAfs4sdfsdfrefefsppD0LjPVJfSuw", p256dh_key: "BD2G1LyFRbbs-h0IqjfvsdfsfwfffsfeymT6gvGnj53WgPegl9OUImd46JNsKggeM0IwPDB2X__kWiGrHP9B5I1Lgg07i8ZiKs"
      end
      it "do not increment webpushnotification count" do
        expect{subject}.to_not change{WebPushNotification.count}
      end

      it "https status to be no content" do
        subject
        expect(response).to have_http_status(:no_content)
      end
      
      
    end
    

     
  end
end
