class SessionLog::CreateJob < ApplicationJob
  queue_as :low
  def perform(user_id)
    user = User.find_by(id: user_id)
    User::CreateSessionLogIntr.run!(user: user) if user.present?
  end
end
