

class ProjectLikeNotification < Noticed::Base
  # Add your delivery methods
  #
   include BroadcastToUsersHelper
   include WebpushHelper

  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  deliver_by :custom, class: "DeliveryMethods::Webpush", delay: 5.minutes, unless: :read?

  # Add required params
  #

   param :project, :action_owner, :total_performers

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end

  after_database :broadcast_project_like



  def webpush_data 
    @project = record[:params][:project]
    @action_owner = record[:params][:action_owner]
    @total_performers = record[:params][:total_performers]


    {
      title: "Project Like",
      body: custom_body(@action_owner, @total_performers, "likes your project, #{project.title}"),
      action_owner: @action_owner,
      total_performers: @total_performers
    }
  end


  def action_cable_data
    { project: record[:params][:project] }
  end


 private 


 def broadcast_project_like 

    project = params[:project]
    

    user = project.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'project_channel', users, false)



 end




  


  #
  # def url
  #   post_path(params[:post])
  # end
end
