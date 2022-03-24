# To deliver this notification:
#
# NewProjectNotification.with(post: @post).deliver_later(current_user)
# NewProjectNotification.with(post: @post).deliver(current_user)

class NewProjectNotification < Noticed::Base
  # Add your delivery methods
  #
    include BroadcastToUsersHelper

   
   deliver_by :database
   # deliver_by :email, mailer: "ProjectMailer"
   # deliver_by :action_cable, channel: WallChannel, format: :action_cable_data
   deliver_by :custom, class: "DeliveryMethods::Webpush", format: :web_push_data, delay: 5.minutes, unless: :read? 
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params

  after_database :broadcast_new_project
  #
   param :project, :action_owner

   def to_database 
    {
      message: @project.title
    }
   end

  # Define helper methods to make rendering easier.
  #
 
  def action_cable_data
    { project: record[:params][:project] }
  end


  def webpush_data 
    @project = record[:params][:project]
    @action_owner = record[:params][:action_owner]
    {
      title: "New Project Added",
      body: "#{@project.user.name} added a new project #{@project.title}",
      project: @project,
      action_owner: @action_owner
    }
  end

  private 

  def broadcast_new_project 



    project = params[:project]
    

    user = project.user


    relay_message_from(user, 'new_project_channel', (user.followers_by_type('User') + user.following_by_type('User')), true)

  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
