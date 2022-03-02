class NewAnticipationChannel < ApplicationCable::Channel
  def subscribed

  	
    stream_from "new_anticipation_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
