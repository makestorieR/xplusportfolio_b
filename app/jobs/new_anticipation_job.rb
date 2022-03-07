class NewAnticipationJob < ApplicationJob
  queue_as :default
  include SubscribeUserHelper

  def perform(*args)
    # Do something later
   
    @anticipation = Anticipation.find_by_id(args.first)
    @user = @anticipation.user

      
    subscribe_user(@anticipation)
    @user = @anticipation.user
       
    NewAnticipationNotification.with(anticipation: @anticipation).deliver (@user.followers_by_type('User') + @user.following_by_type('User'))


    
  end
end
