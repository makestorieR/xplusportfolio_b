class NewAnticipationJob < ApplicationJob
  queue_as :default
  include SubscribeUserHelper

  def perform(*args)
    # Do something later

    


    
    @anticipation = Anticipation.find_by_id(args.first)
    @user = User.find_by_id(@anticipation.user.id)

    #subscribe user followers to anticipation 
    subscribe_user(@anticipation)

    NewAnticipationNotification.with(anticipation: @anticipation).deliver @user.followers


  end
end
