json.array! @activities do |activity|

	json.id activity.id 
	json.owner_name json.owner.name 
	json.type activity.trackable_type
	json.activity activity.trackable 
	json.created_at activity.created_at

end
