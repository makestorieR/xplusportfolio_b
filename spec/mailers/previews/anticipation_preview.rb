# Preview all emails at http://localhost:3000/rails/mailers/anticipation
class AnticipationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/anticipation/new_anticipation_notification
  def new_anticipation_notification
    AnticipationMailer.new_anticipation_notification
  end

end
