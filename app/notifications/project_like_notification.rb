# To deliver this notification:
#
# ProjectLikeNotification.with(post: @post).deliver_later(current_user)
# ProjectLikeNotification.with(post: @post).deliver(current_user)

class ProjectLikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params
  #
   param :project

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  def webpush_data 
    @project = record[:params][:project]
    {
      title: "New Like Alert!",
      body: "#{@project.title} has a new like"
    }
  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
