
class UpvoteNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
   # deliver_by :email, mailer: "ProjectMailer", delay: 1.hours, unless: :read?
  deliver_by :custom, class: "DeliveryMethods::Webpush", format: :web_push_data, delay: 5.minutes, unless: :read? 

  # Add required params
  #
   param :project, :action_owner, :total_performers

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end



  def webpush_data 
    @project = record[:params][:project]
    @action_owner = record[:params][:action_owner]
    @total_performers = record[:params][:total_performers]


    {
      title: "Project Upvote",
      body: "#{@project.title}",
      action_owner: @action_owner,
      total_performers: @total_performers
    }
  end
  
end
