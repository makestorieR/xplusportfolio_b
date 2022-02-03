# To deliver this notification:
#
# NewProjectNotification.with(post: @post).deliver_later(current_user)
# NewProjectNotification.with(post: @post).deliver(current_user)

class NewProjectNotification < Noticed::Base
  # Add your delivery methods
  #
   
   deliver_by :database
   deliver_by :email, mailer: "ProjectMailer"
   deliver_by :action_cable, channel: WallChannel, format: :action_cable_data
   deliver_by :custom, class: "DeliveryMethods::Webpush", format: :web_push_data, delay: 5.minutes, unless: :read? 
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

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


  def webpush_data 
    @project = record[:params][:project]
    {
      title: "New Project Alert!",
      body: "#{@project.user.name} launched a new project #{@project.title}"
    }
  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
