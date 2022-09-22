class User::SetForgotPasswordIntr < ApplicationInteraction
  object :user
  def execute
    pswd = Devise.friendly_token[0, 6] + 'Aa@2'
    user.password = pswd
    user.password_confirmation = pswd
    errors.merge!(user.errors) unless user.save
    [user, pswd]
  end
end
