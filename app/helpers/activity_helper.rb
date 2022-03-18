module ActivityHelper

	def activity_was_performed_previously(object, key, action_owner)

  		object.activities.where(key: key, owner_id: action_owner.id).exists?

  	end

  	def activity_belongs_to_current_user(object, action_owner)
  		object.user.id === action_owner.id 
  	end
end
