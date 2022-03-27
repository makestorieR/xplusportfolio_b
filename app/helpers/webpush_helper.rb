module WebpushHelper
    def send_push_notification(message, webpush)

      

        Webpush.payload_send(
          message: JSON.generate(message),
          endpoint: webpush.endpoint,
          p256dh: webpush.p256dh_key,
          auth: webpush.auth_key,
          vapid: {
            public_key: ENV['VAPID_PUBLIC_KEY'],
            private_key: ENV['VAPID_PRIVATE_KEY']
          },
      
        )
  
  
    end


    def custom_body(action_owner, total_performers, message) 

      others = total_performers >= 1 ? "and #{total_performers} others " : "" 


      custom_body = "#{action_owner} #{others} #{message}"

      custom_body

    end

end

  