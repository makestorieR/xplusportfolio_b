module BroadcastToUsersHelper
	include HashBuilderHelper


	def relay_message_from(user,  channel, users=[], isPost=false, activity=nil)

    	
    	receivers = users.map{|user| {total_notifications: user.notifications.unread.size, slug: user.slug}}

    	@activity = activity


    	if @activity 

    		 data = get_activity_hash(@activity)
    		 ActionCable.server.broadcast "#{channel}",  {receivers: receivers,  sender_slug: user.slug, isPost: isPost, data: data}

    	else

    		 ActionCable.server.broadcast "#{channel}",  {receivers: receivers,  sender_slug: user.slug, isPost: isPost}

    	end
        

	end
end
