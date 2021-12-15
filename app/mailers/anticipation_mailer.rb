class AnticipationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.anticipation_mailer.new_anticipation_notification.subject
  #
  def new_anticipation_notification
  
    
    @anticipation = params[:record][:params][:anticipation]

    # params[:recipient].followers.each do |user|
    #   mail to: user.email
    # end
    @user = params[:recipient]
    mail to: @user.email
  end


  def anticipation_subscription_notification
    @anticipation = params[:record][:params][:anticipation]

    # params[:recipient].followers.each do |user|
    #   mail to: user.email
    # end
    @user = params[:recipient]
    mail to: @user.email
  end
end
