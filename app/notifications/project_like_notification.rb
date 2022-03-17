

class ProjectLikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params
  #
   param :project, :action_performer

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  def webpush_data 
    @project = record[:params][:project]
    @action_performer = record[:params][:action_performer]


    {
      title: "Project Like",
      body: "#{@action_performer.name} likes your project #{@project.title}"
    }
  end


  private 


  #
  # def url
  #   post_path(params[:post])
  # end
end
