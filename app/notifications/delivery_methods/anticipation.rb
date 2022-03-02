
class DeliveryMethods::Anticipation < Noticed::DeliveryMethods::Base
 
  def deliver
    # Logic for sending the notification

    @anticipation = @notification.action_cable_data[:anticipation]

     @user = @anticipation.user

    @receivers = (@user.followers_by_type('User') + @user.following_by_type('User')).map{|user| {total_notifications: user.notifications.unread.size, slug: user.slug}}
        
    ActionCable.server.broadcast 'new_anticipation_channel',  {receivers: @receivers,  sender_slug: @user.slug, isPost: false}

         
   

    # @message = @notification.webpush_data
    #   recipient.webpush_subscriptions.each do |webpush|

    #     begin
    #         send_push_notification(@message, web_push)
    #     rescue  => ex      
    #        web_push.destroy
    #     end

    #   end

  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
