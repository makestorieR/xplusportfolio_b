class NewAnticipationJob < ApplicationJob
  queue_as :default
  include SubscribeUserHelper

  def perform(*args)
    # Do something later
   
    @anticipation = Anticipation.find_by_id(args.first)
    @user = @anticipation.user

      
    subscribe_user(@anticipation)
    

    activity = @anticipation.create_activity :create, owner: @user
    action_owner_info = {name: @user.name, image: @user.image}

     
    NewAnticipationNotification.with(anticipation: @anticipation, action_owner: action_owner_info, activity: activity).deliver (@user.followers_by_type('User') + @user.following_by_type('User'))

    
  end
end
