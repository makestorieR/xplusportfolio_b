module BroadcastToUsersHelper
	def relay_message_from(user,  channel, users=[], isPost=false)

    	
    	receivers = users.map{|user| {total_notifications: user.notifications.unread.size, slug: user.slug}}
        
    	ActionCable.server.broadcast "#{channel}",  {receivers: receivers,  sender_slug: user.slug, isPost: isPost}

	end
end
