class NewAnticipationJob < ApplicationJob
  queue_as :default
  include SubscribeUserHelper

  def perform(*args)
    # Do something later
   
    @anticipation = Anticipation.find_by_id(args.first)
    @user = @anticipation.user

      
         subscribe_user(@anticipation)
         
        NewAnticipationNotification.with(anticipation: @anticipation).deliver (@user.followers_by_type('User') + @user.following_by_type('User'))
   
        @receivers = (@anticipation.user.followers_by_type('User') + @anticipation.user.following_by_type('User')).map{|user| {total_notifications: user.notifications.unread.size, slug: user.slug}}

       ActionCable.server.broadcast 'new_anticipation_channel', {data: {receivers: @receivers,  anticipation: @anticipation, sender_slug: @anticipation.user.slug, isPost: false}}



    # #subscribe user followers to anticipation 
   


    #send notifications to user followers.
    # @user.followers_by_type('User').each do |user| 
    #     # NewAnticipationNotification.with(anticipation: @anticipation).deliver user

    #     ActionCable.server.broadcast "anticipation_notification_channel", {data: @anticipation}

    # end

    #send notifications to users current user is following.
    # @user.following_by_type('User').each do |user| 
        
    #    ActionCable.server.broadcast "anticipation_notification_channel", {data: @anticipation}
    # end

  


   



    
  end
end
