class DeliveryMethods::AnticipationLike < Noticed::DeliveryMethods::Base
  include BroadcastToUsersHelper
  def deliver
    # Logic for sending the notification

    anticipation = @notification.action_cable_data[:anticipation]
    

    user = anticipation.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'anticipation_like_channel', users, false)

    

  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
