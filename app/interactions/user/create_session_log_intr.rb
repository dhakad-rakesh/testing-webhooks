class User::CreateSessionLogIntr < ApplicationInteraction
  object :user
  def execute
    return if user.session_logs.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).present?
    user.session_logs.create
  end
end
