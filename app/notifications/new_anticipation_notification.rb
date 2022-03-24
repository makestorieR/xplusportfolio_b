# To deliver this notification:
#
# NewAnticipationNotification.with(post: @post).deliver_later(current_user)
# NewAnticipationNotification.with(post: @post).deliver(current_user)

class NewAnticipationNotification < Noticed::Base
  include BroadcastToUsersHelper
  deliver_by :database
  # deliver_by :custom, class: "DeliveryMethods::Anticipation"
  # deliver_by :email, mailer: "AnticipationMailer", delay: 1.hours, unless: :read?
  
  # deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?
  deliver_by :custom, class: "DeliveryMethods::Webpush"
 

  # Add required params
  #
   param :anticipation, :action_owner, :activity

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  after_database :broadcast_new_anticipation

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    @action_owner = record[:params][:action_owner]
   


    {
      title: "New Anticipation",
      body: "#{@anticipation.body}",
      action_owner: @action_owner
    }
  end



  def action_cable_data
    { anticipation: record[:params][:anticipation], activity: record[:params][:activity] }
  end

  private 

  def broadcast_new_anticipation
    # Logic for sending the notification

    anticipation = params[:anticipation]
    activity = params[:activity]
    

    user = anticipation.user


    relay_message_from(user, 'new_anticipation_channel', (user.followers_by_type('User') + user.following_by_type('User')), true, activity)

  end

  private 

  def broadcast_new_anticipation
    # Logic for sending the notification

    anticipation = params[:anticipation]
    

    user = anticipation.user


    relay_message_from(user, 'new_anticipation_channel', (user.followers_by_type('User') + user.following_by_type('User')), true)

  end
end
