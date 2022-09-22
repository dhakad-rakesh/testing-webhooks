class Casino::CreateGameSessionJob < ApplicationJob
  queue_as :game_sessions

  def perform(user_id, params)
    user = User.find_by(id: user_id)
    user.game_sessions.create(session_params(user, params))
  end

  private

  def session_params(user, params)
    params.symbolize_keys
          .slice(:game_uuid, :currency, :session_id, :return_url)
          .merge(wallet_amount: user.available_amount,
                 start_time: Time.zone.now)
  end
end
