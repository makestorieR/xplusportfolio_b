class ProjectUpvoteJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later


    	@project = Project.friendly.find(args.first)
    	action_owner  = User.all.friendly.find(args.last) 


    	

       if !activity_previously_performed_by action_owner 

       		@project.create_activity :upvote, owner: action_owner
       		UpvoteNotification.with(project: @project).deliver @project.user
       		

       end
  end

  private 

  def activity_previously_performed_by(action_owner)

  	@project.activities.where(key: 'project.upvote', owner_id: action_owner.id).exists?

  end
end
