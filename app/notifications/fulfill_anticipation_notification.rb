# To deliver this notification:
#
# FulfillAnticipationNotification.with(post: @post).deliver_later(current_user)
# FulfillAnticipationNotification.with(post: @post).deliver(current_user)

class FulfillAnticipationNotification < Noticed::Base
     include BroadcastToUsersHelper
  
  deliver_by :database
  # deliver_by :custom, class: "DeliveryMethods::Anticipation"
  # deliver_by :email, mailer: "AnticipationMailer", delay: 1.hours, unless: :read?
  
  # deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?
  deliver_by :custom, class: "DeliveryMethods::Webpush"

  after_database :broadcast_fulfill_anticipation
 

  # Add required params
  #
  param :anticipation, :action_owner

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    @action_owner = record[:params][:action_owner]
   


    {
      title: "Anticipation Fulfilled",
      body: "#{@anticipation.user.name} fulfilled anticipation #{@anticipation.body}",
      action_owner: @action_owner
    }
  end





  def action_cable_data
    { anticipation: record[:params][:anticipation] }
  end

  private 

  def broadcast_fulfill_anticipation
    # Logic for sending the notification

    anticipation = params[:anticipation]
    

    user = anticipation.user

    users = []
    users.push(user)

    anticipation.followers_by_type('User').each do |subscriber|
      users.push(subscriber)
    end








    
    relay_message_from(user, 'anticipation_channel', users, false)

  end
end
