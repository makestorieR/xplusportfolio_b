module ActivityHelper

	def activity_was_performed_previously(object, key, action_owner)

  		object.activities.where(key: key, owner_id: action_owner.id).exists?

  	end
end
