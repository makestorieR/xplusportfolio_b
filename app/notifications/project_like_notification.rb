

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

  before_database :check

  def webpush_data 
    @project = record[:params][:project]
    {
      title: "Project Like",
      body: "#{@project.title} has a new like"
    }
  end


  private 

  def check 

    debugger
  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
