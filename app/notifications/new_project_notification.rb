# To deliver this notification:
#
# NewProjectNotification.with(post: @post).deliver_later(current_user)
# NewProjectNotification.with(post: @post).deliver(current_user)

class NewProjectNotification < Noticed::Base
  # Add your delivery methods
  #
   
   deliver_by :database
   deliver_by :email, mailer: "ProjectMailer", delay: 1.day, unless: :read?
   deliver_by :action_cable, channel: WallChannel, format: :action_cable_data
   deliver_by :custom, class: "DeliveryMethods::NewProjectPush", delay: 60.minutes, unless: :read?
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  before_action_cable :set_data

  # Add required params
  #
   param :project

   def to_database 
    {
      message: @project.title
    }
   end

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end

  def custom_stream
    "user_#{recipient.id}"
  end

  def action_cable_data
    { project: record[:params][:project] }
  end

  private 

  def set_data 

    @project = record[:params][:project]

    
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
