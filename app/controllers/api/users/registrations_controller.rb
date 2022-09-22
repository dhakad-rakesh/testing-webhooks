class Api::Users::RegistrationsController < Api::BaseController
  include Api::RegistrationAndLoginProcess
  skip_before_action :user_authorize!, only: %I[create check_phone_availability metamask_user metamask_address_exist]
  before_action :validate_referral_code, only: :metamask_user
  before_action :set_admin, only: :metamask_user

  def create
    outcome, @user = Onboarding::DeviseCreateUserIntr.run(sign_up_params)
    return render_sign_in(outcome.result) if outcome.valid?
    render_error_output(outcome.errors.full_messages.first)
  end

  def update
    return render_not_found_response(I18n.t('users.not_found')) unless current_user
    outcome = User::UpdateUserIntr.run(sign_up_params)
    return update_success_response(outcome.user) if outcome.valid?
    render_error_output(outcome.errors.full_messages.first)
  end

  def check_phone_availability
    outcome = Onboarding::CheckPhoneAvailabilityIntr.run(phone: params[:phone])
    return render_success_response(I18n.t('users.phone.available')) if outcome.valid?
    render json: {
      phone: outcome.result&.phone,
      unverified_phone: outcome.result&.unverified_phone,
      message: outcome.errors.full_messages.first
    }, status: 400
  end

  def metamask_user
    return render_error_output('Address cant be blank') unless metamask_params[:metamask_address] 
    # admin = AdminUser.with_role(:super_admin).first
    user = User.new(metamask_user_params.merge(admin_user_id: @admin.id).merge(referral_params))
    return render_sign_in(user) if user.save
    render_error_output(user.errors.full_messages.first)
  end

  def metamask_address_exist
    return render_error_output('Address cant be blank') unless params[:metamask_address]
    user = User.find_by(metamask_address: params[:metamask_address])
    return render_sign_in(user) if user
    render_error_output(I18n.t('users.not_found'))
  end

  private

  def sign_up_params
    params.permit(:username, :password, :password_confirmation, :email, :referral_code, :affiliate_code).merge(user: current_user)
    # :username, :first_name, :last_name, :phone, :password, :password_confirmation, :currency, :referral_code
  end

  def render_sign_in(user)
    @user = user
    sign_in(validate_password: false)
  end

  def update_success_response(user)
    render json: { result: {
      access_token: user.access_token.token,
      user: UserSerializer.new(user, include: [], scope_name: 'current_user')
      }}
  end

  def metamask_username
    address = metamask_params.dig(:metamask_address)
    "#{address.first(4)}#{address.last(4)}"
  end

  def metamask_params
    params.permit(:metamask_address)
  end

  def metamask_user_params
    metamask_params.merge(user_type: :metamask, username: metamask_username)
  end

  def validate_referral_code
    return unless params.dig(:referral_code)&.present?
    return render_error_output('users.referral_code.inactive') unless GammabetSetting.referral_bonus_allowed?
    @referrer = User.find_by(referral_code: params[:referral_code])
    return if @referrer.present?
    render_error_output(I18n.t('users.referral_code.invalid'))
  end

  def referral_params
    return {} if @referrer.blank?
    {
      referrer_relation_attributes: {
        referrer_id: @referrer.id,
        reward_amount: GammabetSetting.referral_reward_amount || 0,
        threshold_amount: GammabetSetting.referral_threshold_amount || 5
      }
    }
  end

  def set_admin
    @admin =  AdminUser.with_role(:super_admin).first
    if params[:affiliate_code] 
      admin = AdminUser.find_by(code: params[:affiliate_code])
      @admin = admin if admin&.undiscarded?
    end
  end
end
