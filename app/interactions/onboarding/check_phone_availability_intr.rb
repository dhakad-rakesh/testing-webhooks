class Onboarding::CheckPhoneAvailabilityIntr < ApplicationInteraction
  string :phone

  validates :phone, phone: true

  set_callback :type_check, :after, :validate_user_phone

  def execute
    if user
      errors.add(:base, I18n.t('users.phone.registered'))
      return user
    end
  end

  def user
    @user ||= User.where(phone: phone).first
  end

  def validate_user_phone
    return if Phonelib.parse("+#{phone}").valid?
    errors.add(:base, I18n.t('users.phone.invalid'))
  end
end
