class AnticipationNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "anticipation_notification_channel"
     
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
