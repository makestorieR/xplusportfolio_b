class NewProjectJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    
    @project = Project.find_by_id(args.first)
    @user = @project.user

    @project.create_activity :create, owner: @user
    action_owner_info = {name: @user.name, image: @user.image}

    NewProjectNotification.with(project: @project, action_owner: action_owner_info).deliver (@user.followers_by_type('User') + @user.following_by_type('User'))

  end
end
