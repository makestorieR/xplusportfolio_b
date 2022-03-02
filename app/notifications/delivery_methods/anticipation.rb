
class DeliveryMethods::Anticipation < Noticed::DeliveryMethods::Base
 
  def deliver
    # Logic for sending the notification

    @anticipation = @notification.action_cable_data

    



     ActionCable.server.broadcast 'new_anticipation_channel', {data: {current_user: @anticipation[:anticipation].user}}  


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
