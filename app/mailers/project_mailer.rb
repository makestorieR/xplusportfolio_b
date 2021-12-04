class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.new_project.subject
  #
  def new_project
    @greeting = "Hi"

    mail to: "johnnonso090@gmail.com"
  end

  def new_project_notification
    @greeting = "Hi"

    mail to: "johnnonso090@gmail.com"
  end
end
