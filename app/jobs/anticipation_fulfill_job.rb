class AnticipationFulfillJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    @anticipation = Anticipation.find_by_id(args.first)
    @user = @anticipation.user


    @anticipation.create_activity :fulfill, owner: @user
    action_owner_info = {name: @user.name, image: @user.image}


    subscribers = @anticipation.followers_by_type('User')

     
    FulfillAnticipationNotification.with(anticipation: @anticipation, action_owner: action_owner_info).deliver subscribers

  end
end
