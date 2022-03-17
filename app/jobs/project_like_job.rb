class ProjectLikeJob < ApplicationJob
  include ActivityHelper
  queue_as :default

  def perform(*args)
    # Do something later

    @project = Project.friendly.find(args.first)
	action_owner  = User.all.friendly.find(args.last) 


   unless activity_was_performed_previously(@project, 'project.like', action_owner)  
   		@project.create_activity :like, owner: action_owner
   		ProjectLikeNotification.with(project: @project, action_performer: action_owner).deliver @project.user	
   end


  end
end
