class Onboarding::DeviseCreateUserIntr < ApplicationInteraction

  # string :first_name
  # string :last_name
  # string :phone
  # string :currency
  string :username
  string :password
  string :password_confirmation
  string :email
  string :referral_code, default: nil
  string :affiliate_code, default: nil

  # ALLOWED_NAME_FORMAT = /\A[a-zA-Z]+\z/

  # set_callback :type_check, :after, :validate_user_phone
  set_callback :type_check, :after, :user
  set_callback :type_check, :before, :validate_referral_code
  set_callback :type_check, :before, :set_admin

  # validates :phone, phone: true
  # validate :validate_supported_currency
  validate :validate_email_uniquness
  validate :validate_password_mismatch

  def execute
    unless @user.valid?
      merge_errors(errors.messages, @user.errors.messages)
      return @user
    end
    User.transaction do
      @user.admin_user_id = @admin.id
      @user.save!
      # create_currency_wallet!
      @user
    end
  rescue ActiveRecord::RecordInvalid
    merge_errors(errors, @user.errors)
    @user
  rescue ActiveRecord::RecordNotUnique
    errors.add(:base, I18n.t('users.phone.registered'))
    @user
  end

  def merge_errors(errors, errors_messages)
    errors.merge!(errors_messages) unless @user.valid?
  end

  def user
    @user ||= User.new(new_user_params.merge(referral_params))
  end

  def new_user_params
    {username: username, password: password, password_confirmation: password_confirmation, unconfirmed_email: email}
  end

  # TODO: Deprecate updating phone directly, 
  # use unverified phone instead
  def user_params
    inputs.except(:currency, :referral_code, :country_alpha3, :agent_code)
          .merge(referral_params)
          .merge(address_params)
          .merge(admin_params)
  end

  def referral_params
    return {} if @referrer.blank?
    { 
      referrer_relation_attributes: { 
        referrer_id: @referrer.id,
        reward_amount: current_referral_reward_amount,
        threshold_amount: current_referral_threshold_amount
      }
    }
  end

  def address_params
    { address_attributes: { country: country.name } }
  end

  def admin_params
    return {} if @admin_user.blank?

    { admin_user_id: @admin_user.id }
  end

  def create_currency_wallet!
    @user.create_currency_wallet!(currency)
  end

  def validate_user_phone
    old_user = User.find_by(phone: inputs[:phone])
    return unless old_user
    errors.add(:base, I18n.t('users.phone.registered'))
  end

  def validate_password_mismatch
    return if password == password_confirmation
    errors.add(:password, I18n.t('users.password.confirmation_mismatch'))
  end

  def validate_supported_currency
    return if Constants::SUPPORTED_CURRENCIES.include?(currency)
    errors.add(:base, 'Currency is not valid')
  end

  def validate_referral_code 
    return unless referral_code.present?
    return errors.add(:base, I18n.t('users.referral_code.inactive')) unless GammabetSetting.referral_bonus_allowed?
    @referrer = User.find_by(referral_code: referral_code)
    return if @referrer.present?
    errors.add(:base, I18n.t('users.referral_code.invalid'))
  end

  def validate_agent_code
    @admin_user = AdminUser.find_by(code: agent_code)
    return if agent_code.blank? || @admin_user.present?

    errors.add(:base, I18n.t('users.agent.invalid'))
  end

  def validate_email_uniquness
    if email.blank?
      errors.add(:base, I18n.t('users.email.email_required')) 
      return
    end
    user_exist = User.where('email = ? OR unconfirmed_email = ?',email,email).exists?
    errors.add(:base, I18n.t('users.email.email_already_used')) if user_exist
  end

  def current_referral_reward_amount
    # GammabetSetting.referral_reward_amount[@referrer.current_wallet.currency] || 100
    GammabetSetting.referral_reward_amount || 0
  end

  def current_referral_threshold_amount
    # GammabetSetting.referral_threshold_amount[@referrer.current_wallet.currency] || 100
    GammabetSetting.referral_threshold_amount || 5
  end

  def country
    @country ||= ISO3166::Country.find_country_by_alpha3(country_alpha3)
  end

  def set_admin
    @admin =  AdminUser.with_role(:super_admin).first
    if affiliate_code 
      admin = AdminUser.find_by(code: affiliate_code)
      @admin = admin if admin&.undiscarded?
    end
  end
end
