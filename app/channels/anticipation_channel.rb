class AnticipationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "anticipation_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
