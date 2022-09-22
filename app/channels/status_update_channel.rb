class StatusUpdateChannel < ApplicationCable::Channel  
  def subscribed
    channel_name = Constants::STATUS_UPDATE_CHANNEL
    stream_from "#{channel_name}/#{params[:match_id]}"
  end
end
