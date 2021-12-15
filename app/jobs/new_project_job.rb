class NewProjectJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    
    @project = Project.find_by_id(args.first)
    @user = @project.user

    NewProjectNotification.with(project: @project).deliver @user.followers

    


  end
end
