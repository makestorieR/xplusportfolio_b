class ProjectUpvoteJob < ApplicationJob
  include ActivityHelper
  queue_as :default


  def perform(*args)
    # Do something later


    	@project = Project.friendly.find(args.first)
    	action_owner  = User.all.friendly.find(args.last) 


       unless activity_was_performed_previously(@project, 'project.upvote', action_owner)  
       		@project.create_activity :upvote, owner: action_owner
       		UpvoteNotification.with(project: @project).deliver @project.user
       		
       end
  end

end
