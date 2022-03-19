class AnticipationSubscriptionJob < ApplicationJob
  queue_as :default
  include ActivityHelper

	def perform(*args)
	    # Do something later


	        @anticipation = Anticipation.find_by_id(args.first)
	    	action_owner  = User.all.friendly.find(args.last) 

	    	return if activity_belongs_to_current_user @anticipation, action_owner


	        unless activity_was_performed_previously(@anticipation, 'anticipation.subscribe', action_owner)  
	       		total_performers = (@anticipation.followers_by_type_count('User') - 1)
	       		@anticipation.create_activity :subscribe, owner: action_owner
	       		action_owner_info = {name: action_owner.name, image: action_owner.image}

	       		AnticipationSubscriptionNotification.with(anticipation: @anticipation, action_owner: action_owner_info, total_performers: total_performers ).deliver @anticipation.user
	       		
	        end
	  end
end
