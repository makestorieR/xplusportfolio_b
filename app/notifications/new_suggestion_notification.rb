# To deliver this notification:
#
# NewSuggestionNotification.with(post: @post).deliver_later(current_user)
# NewSuggestionNotification.with(post: @post).deliver(current_user)

class NewSuggestionNotification < Noticed::Base
     include BroadcastToUsersHelper

   deliver_by :database
   # deliver_by :email, mailer: "ProjectMailer", delay: 1.hours, unless: :read?
   deliver_by :custom, class: "DeliveryMethods::Webpush", format: :web_push_data, delay: 5.minutes, unless: :read? 
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
   param :suggestion, :action_owner, :project


  # Define helper methods to make rendering easier.
  #

  after_database :broadcast_suggestion

    def action_cable_data
    { project: record[:params][:project] }
  end
 

  def webpush_data 
    @suggestion = record[:params][:suggestion]
    @action_owner = record[:params][:action_owner]
    @project = @suggestion.project

    {
      title: "New Project Suggestion!",
      body: "Your #{@project.title} have a new suggestion",
      suggestion: @suggestion,
      action_owner: @action_owner,
      project: @project
    }
  end


  private 


  def broadcast_suggestion

    project = params[:project]
    

    user = project.user

    users = []
    users.push(user)

    relay_message_from(@recipient, 'project_channel', users, false)



  end

end
