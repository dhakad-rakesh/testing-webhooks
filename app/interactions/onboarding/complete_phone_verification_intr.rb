class Onboarding::CompletePhoneVerificationIntr < ApplicationInteraction
  object :user

  string :otp
  string :token
  boolean :update_phone, default: true

  # validate :validate_user_transition

  def execute
    result = Users::VerifyPhoneService.call(user_phone, otp, token)
    unless result
      errors.add(:base, I18n.t('users.phone.verification.failed'))
      return
    end
    User.transaction do
      user.update_attributes!(phone: user_phone, unverified_phone: nil) if user_phone
      user.complete_sign_up!
    end
  rescue CustomErrors::PhoneVerificationError
    errors.add(:base, I18n.t('users.phone.verification.failed'))
  # TODO: Add custom error classes, Add generic handler for now
  rescue Exception => e
    errors.add(:base, e.message)
  end

  def validate_user_transition
    return if user.may_complete_phone_verification?
    errors.add(:user, I18n.t(:invalid_state_transition))
  end

  # def update_phone
  #   return if user.unverified_phone.blank?
  #   user.update_attributes!(
  #     phone: user.unverified_phone,
  #     unverified_phone: nil
  #   )
  # end

  def user_phone
    if update_phone && user.completed_sign_up?
      user.unverified_phone
    else
      user.phone
    end
  end
end