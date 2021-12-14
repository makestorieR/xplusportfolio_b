class DeliveryMethods::NewProjectPush < Noticed::DeliveryMethods::Base
  include WebpushHelper
  def deliver
    # Logic for sending the notification

    @message = {
      title: "New Project Alert!",
      body: "#{recipient.name} Just created a new project"
    }

    recipient.followers.each do |user|

      user.webpush_subscriptions.each do |webpush|

        begin
            send_push_notification(@message, web_push)
        rescue  => ex      
           web_push.destroy
        end

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
