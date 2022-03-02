

json.notification_info do

	json.total_notifications @notifications.size

	json.notifications @notifications do |notification|
		json.id notification.id
	    json.type notification.type 
	    json.read notification.read?
	    json.object notification.params
	    
	    json.user_slug notification.params[:anticipation].user.slug if notification.params[:anticipation]

	end

end