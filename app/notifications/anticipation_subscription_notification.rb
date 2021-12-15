# To deliver this notification:
#
# AnticipationSubscriptionNotification.with(post: @post).deliver_later(current_user)
# AnticipationSubscriptionNotification.with(post: @post).deliver(current_user)

class AnticipationSubscriptionNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
   deliver_by :email, mailer: "AnticipationMailer", delay: 1.hour, unless: :read?
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params
  #
  param :anticipation

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  def webpush_data 
    @anticipation = record[:params][:anticipation]
    {
      title: "New Anticipation Subscriber",
      body: "#{@anticipation.body} has a new subscriber"
    }
  end
end
