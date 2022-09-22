class User::PromoCodeVerificationIntr < ApplicationInteraction
  object :user
  string :code_name
  float  :deposit_amount

  set_callback :type_check, :after, :validate_promo_code
  set_callback :validate, :after, :validate_expired_code
  set_callback :validate, :after, :validate_availability
  set_callback :validate, :after, :validate_availability_for_user
  set_callback :validate, :after, :validate_threshold_amount

  def execute
    promo_code.details(currency)
  end

  def promo_code
    @promo_code ||= PromoCode.find_by(code: code_name)
  end

  # Do not reveal future codes
  def validate_promo_code
    errors.add(:base, I18n.t('errors.messages.promo_code.invalid')) if promo_code.blank? || promo_code.inactive?
  end

  def validate_expired_code
    errors.add(:base, I18n.t('errors.messages.promo_code.expired')) if promo_code.expired?
  end

  def validate_availability
    errors.add(:base, I18n.t('errors.messages.promo_code.limit_exhausted')) if promo_code.limit_exhausted?
  end

  def validate_availability_for_user
    errors.add(:base, I18n.t('errors.messages.promo_code.not_available')) unless promo_code.available_for_user(user)
  end

  def validate_threshold_amount
    if promo_code.threshold_amount[currency].to_f > deposit_amount
      errors.add(:base, invalid_deposit_message)
    end
  end

  def currency
    @currency ||= user.current_wallet.currency
  end

  def invalid_deposit_message
    I18n.t('errors.messages.promo_code.invalid_deposit_amount',
      amount: promo_code.threshold_amount[currency]
    )
  end
end
