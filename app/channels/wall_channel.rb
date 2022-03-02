class WallChannel < ApplicationCable::Channel
    def subscribed

    stream_from "wall_channel"
    
  end

  def unsubscribed
    stop_all_streams
  end
end
