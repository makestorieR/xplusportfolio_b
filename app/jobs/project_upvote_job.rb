class ProjectUpvoteJob < ApplicationJob
  include ActivityHelper
  queue_as :default


  def perform(*args)
    # Do something later


    	@project = Project.friendly.find(args.first)
    	action_owner  = User.all.friendly.find(args.last) 

      return if activity_belongs_to_current_user @project, action_owner


       unless activity_was_performed_previously(@project, 'project.upvote', action_owner)  
       		
          total_performers = (@project.get_upvotes.size - 1)
          @project.create_activity :upvote, owner: action_owner
          action_owner_info = {name: action_owner.name, image: action_owner.image}

          UpvoteNotification.with(project: @project, action_owner: action_owner_info, total_performers: total_performers ).deliver @project.user
          
       		
       end

        
  end

end
