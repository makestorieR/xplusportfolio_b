# To deliver this notification:
#
# NewAnticipationNotification.with(post: @post).deliver_later(current_user)
# NewAnticipationNotification.with(post: @post).deliver(current_user)

class NewAnticipationNotification < Noticed::Base
   
  deliver_by :database
  # deliver_by :custom, class: "DeliveryMethods::Anticipation"
  # deliver_by :email, mailer: "AnticipationMailer", delay: 1.hours, unless: :read?
  
  # deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?
  deliver_by :custom, class: "DeliveryMethods::Webpush"
 

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
      title: "New Anticipation",
      body: "#{@anticipation.body}",
      action_owner: @action_owner
    }
  end





  def action_cable_data
    { anticipation: record[:params][:anticipation] }
  end
end
