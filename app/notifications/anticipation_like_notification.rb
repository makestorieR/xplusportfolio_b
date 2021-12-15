# To deliver this notification:
#
# AnticipationLikeNotification.with(post: @post).deliver_later(current_user)
# AnticipationLikeNotification.with(post: @post).deliver(current_user)

class AnticipationLikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
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
      title: "New Like Alert!",
      body: "#{@anticipation.body} has a new like"
    }
  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
