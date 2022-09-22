class UserBalanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "current_user_#{current_user.id}"
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def speak(data)
  #   ActionCable.server.broadcast "user_balance_channel", message: data['message']
  # end
end
