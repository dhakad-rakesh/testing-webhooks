class User::UpdateUserIntr < ApplicationInteraction
  object :user

  string :username
  string :password
  string :password_confirmation
  string :email, default: ""

  validate :validate_password_mismatch

  def execute
    user.assign_attributes(user_params)
    unless user.errors.blank?
      merge_errors(errors.messages, user.errors.messages)
      return user
    end
    User.transaction do
      user.save!
      user
    end
  rescue Exception => e
    errors.add(:base, e.message)
  end

  def merge_errors(errors, errors_messages)
    errors.merge!(errors_messages) unless user.errors.blank?
  end

  def user_params
    {username: username, password: password, password_confirmation: password_confirmation, email: email}
  end

  def validate_password_mismatch
    return if password.eql?(password_confirmation)
    errors.add(:password, I18n.t('users.password.confirmation_mismatch'))
  end

end
