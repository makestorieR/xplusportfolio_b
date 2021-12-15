# To deliver this notification:
#
# UpvoteNotification.with(post: @post).deliver_later(current_user)
# UpvoteNotification.with(post: @post).deliver(current_user)

class UpvoteNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
   deliver_by :email, mailer: "ProjectMailer", delay: 1.hours, unless: :read?
   deliver_by :custom, class: "DeliveryMethods::Webpush", format: :web_push_data, delay: 5.minutes, unless: :read? 

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
      title: "Upvote!!",
      body: "Your Project #{@project.title} has recieved a new upvote"
    }
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
