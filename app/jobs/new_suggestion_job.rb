class NewSuggestionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    @suggestion = Suggestion.find_by_id(args.first)

    
    @user = @suggestion.user

    @suggestion.create_activity :create, owner: @user
    action_owner_info = {name: @user.name, image: @user.image}

    NewSuggestionNotification.with(suggestion: @suggestion, action_owner: action_owner_info).deliver @suggestion.project.user

  end
end
