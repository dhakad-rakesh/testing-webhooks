class ScoreUpdateChannel < ApplicationCable::Channel  
  def subscribed
    channel_name = Constants::SCORE_UPDATE_CHANNEL
    stream_from "#{channel_name}/#{params[:match_id]}"
  end
end
