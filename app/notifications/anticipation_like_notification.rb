# To deliver this notification:
#
# AnticipationLikeNotification.with(post: @post).deliver_later(current_user)
# AnticipationLikeNotification.with(post: @post).deliver(current_user)

class AnticipationLikeNotification < Noticed::Base
    include BroadcastToUsersHelper
  # Add your delivery methods

  
  #
  deliver_by :database
  # deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params
  #
   param :anticipation

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  after_database :broadcast_anticipation_like

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    {
      title: "New Like Alert!",
      body: "#{@anticipation.body} has a new like"
    }
  end


  def broadcast_anticipation_like
    # Logic for sending the notification


    

    anticipation = params[:anticipation]
    

    user = anticipation.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'anticipation_like_channel', users, false)

    

  end

 
  def action_cable_data
    { anticipation: record[:params][:anticipation] }
  end
end
