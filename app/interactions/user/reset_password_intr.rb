class User::ResetPasswordIntr < ApplicationInteraction
  string :password
  string :password_confirmation
  string :reset_password_token

  def execute
    user =  User.transaction do
              user = User.reset_password_by_token(password_params)
              user.update!(confirmed_at: Date.today) unless user.errors.any? || user.confirmed?
              user
            end
    errors.merge!(user.errors) if user.errors.any?
  end

  def password_params
    inputs.slice(:reset_password_token, :password, :password_confirmation)
  end
end
