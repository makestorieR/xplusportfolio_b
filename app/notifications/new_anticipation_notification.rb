# To deliver this notification:
#
# NewAnticipationNotification.with(post: @post).deliver_later(current_user)
# NewAnticipationNotification.with(post: @post).deliver(current_user)

class NewAnticipationNotification < Noticed::Base
   
  deliver_by :database
  deliver_by :custom, class: "DeliveryMethods::Anticipation"
  # deliver_by :email, mailer: "AnticipationMailer", delay: 1.hours, unless: :read?
  
  # deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?
  deliver_by :custom, class: "DeliveryMethods::Webpush"
 

  # Add required params
  #
   param :anticipation

   def to_database 
    {
      message: @anticipation.title
    }
   end

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    {
      title: "New Anticipation Alert!",
      body: "#{@anticipation.user.name} launched a new anticipation #{@anticipation.body}"
    }
  end

  def custom_stream

    
    "user_#{recipient.id}"
  end

  def action_cable_data
    { anticipation: record[:params][:anticipation] }
  end
end
