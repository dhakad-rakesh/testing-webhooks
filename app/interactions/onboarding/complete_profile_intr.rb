class Onboarding::CompleteProfileIntr < ApplicationInteraction
  object :user

  string :currency
  string :password

  validate :supported_currency
  # validate :validate_user_transition

  def execute
    user.assign_attributes(user_params)
    unless user.valid?
      merge_errors(errors.messages, user.errors.messages)
      return user
    end
    User.transaction do
      @user.save!
      create_currency_wallet!
      @user.complete_sign_up!
    end
  end

  def merge_errors(errors, errors_messages)
    errors.merge!(errors_messages) unless user.valid?
  end

  def user_params
    inputs.slice(:password)
  end

  def validate_user_transition
    return if user.may_complete_profile?
    errors.add(:user, I18n.t(:invalid_state_transition))
  end

  def create_currency_wallet!
    @user.create_currency_wallet!(currency)
  end

  def supported_currency
    return if Constants::SUPPORTED_CURRENCIES.include?(currency)
    errors.add(:wallets, I18n.t(:currency_not_valid))
  end

end
  