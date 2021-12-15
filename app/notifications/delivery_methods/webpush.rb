class DeliveryMethods::Webpush < Noticed::DeliveryMethods::Base
  include WebpushHelper
  def deliver
    # Logic for sending the notification

    @message = @notification.webpush_data
      recipient.webpush_subscriptions.each do |webpush|

        begin
            send_push_notification(@message, web_push)
        rescue  => ex      
           web_push.destroy
        end

      end

  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
