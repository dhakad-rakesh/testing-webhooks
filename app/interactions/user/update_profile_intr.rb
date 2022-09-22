class User::UpdateProfileIntr < ApplicationInteraction
  object :user
  hash :params, strip: false, default: {}
  string :otp, default: ''
  string :token, default: ''
  
  # validate :validate_phone
  # validate :validate_currency_change

  def execute
    if params[:password].present?
      user.update_with_password(password_params)
    else
      user.assign_attributes(user_params)
    end
    unless user.errors.blank? && verified?
      merge_errors(errors.messages, user.errors.messages)
      return user
    end
    User.transaction do
      # update_metamask_status if params[:two_factor_authentication] && user.valid?
      # update_metamask_status if params[:two_factor_authentication] && user.valid?
      # Metamask::UpdateTwoFactorStatusJob.perform_now(user, status_params) 
      user.save!
      update_wallet
      user
    end
  rescue CustomErrors::PhoneVerificationError
    errors.add(:base, I18n.t('users.phone.verification.failed'))
  rescue ActiveRecord::RecordNotUnique
    errors.add(:base, I18n.t('users.phone.registered'))
    user
  rescue Exception => e
    errors.add(:base, e.message)
  end

  def merge_errors(errors, errors_messages)
    errors.merge!(errors_messages) unless user.errors.blank?
  end

  def validate_currency_change
    return if params[:currency].blank?
    validate_empty_wallet
    validate_supported_currency
  end

  def validate_empty_wallet
    return if user.current_wallet.available_amount == 0
    errors.add(:wallet, I18n.t(:currency_cant_change))
  end

  def validate_supported_currency
    return if Constants::SUPPORTED_CURRENCIES.include?(params[:currency])
    errors.add(:currency, I18n.t(:not_valid))
  end

  def update_wallet
    return unless params[:currency]
    user.current_wallet.update(currency: params[:currency])
  end
  
  def user_params
    params.except(
      :currency, :phone, :password, :password_confirmation, :current_password
    ).merge(unverified_phone: phone).compact
  end

  def password_params
    params.slice(:password, :password_confirmation, :current_password)
  end

  def validate_phone
    return if phone.blank? || Phonelib.valid?(phone)
    errors.add(:phone, :invalid)
  end

  def phone
    params[:phone]
  end

  def verified?
    if user.unverified_phone_changed? && !otp_verification_successful?
      errors.add(:base, I18n.t(:cant_verify_otp))
      return false
    end
    true
  end

  def otp_verification_successful?
    Users::VerifyPhoneService.call(user.phone, otp, token) 
  end

  def update_metamask_status
    response = client.post('setUserTwoFactorAuthenticationStatus', status_params)
    return error_response if response.try(:code) != '200'
    data = JSON.parse(response.body)
    return error_response unless data['success']
    user.two_factor_status = 1
  end

  def status_params
   {
    "userDepositContractAddress": user.deposit_address,
    "twoFactorAuthenticationStatus": params[:two_factor_authentication].present?
   }
  end

  def error_response
    errors.add(:base, 'Failed from blockchain')
  end
  
  def client
    @client ||= Metamask::Client.new
  end
end
