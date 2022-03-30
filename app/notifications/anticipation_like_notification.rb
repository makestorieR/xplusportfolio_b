# To deliver this notification:
#
# AnticipationLikeNotification.with(post: @post).deliver_later(current_user)
# AnticipationLikeNotification.with(post: @post).deliver(current_user)

class AnticipationLikeNotification < Noticed::Base
    include BroadcastToUsersHelper
    include WebpushHelper
  # Add your delivery methods

  
  #
  deliver_by :database
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required param
  #
  param :anticipation, :action_owner, :total_performers

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  after_database :broadcast_anticipation_like

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    @action_owner = record[:params][:action_owner]
    @total_performers = record[:params][:total_performers]

  
    {
      title: "Anticipation Like",
      body: custom_body(@action_owner[:name], @total_performers, "likes your anticipation, #{anticipation.body}"),
      action_owner: @action_owner,
      total_performers: @total_performers
    }
  end


  def broadcast_anticipation_like
    # Logic for sending the notification


    

    anticipation = param[:anticipation]
    

    user = anticipation.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'anticipation_channel', users, false)

    

  end

 
  def action_cable_data
    { anticipation: record[:param][:anticipation] }
  end
end
