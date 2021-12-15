class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #
 
  def new_project_notification

    
    @project = params[:record][:params][:project]

    # params[:recipient].followers.each do |user|
    #   mail to: user.email
    # end
    @user = params[:recipient]
    mail to: @user.email
   
  end


  def upvote_notification 
    @project = params[:record][:params][:project]


    @user = params[:recipient]
    mail to: @user.email
  end


  def new_suggestion_notification 
    @suggestion = params[:record][:params][:suggestion]
    @project = @suggestion.project
    @user = params[:recipient]
    mail to: @user.email
  end
end
