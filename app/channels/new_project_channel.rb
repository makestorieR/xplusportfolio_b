class NewProjectChannel < ApplicationCable::Channel
  def subscribed
    stream_from "new_project_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    
  end
end
