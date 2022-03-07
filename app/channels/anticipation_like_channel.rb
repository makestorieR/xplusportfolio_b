class AnticipationLikeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "anticipation_like_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
