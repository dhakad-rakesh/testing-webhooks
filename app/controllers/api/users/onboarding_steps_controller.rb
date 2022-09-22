class Api::Users::OnboardingStepsController < Api::BaseController
  include Api::RegistrationAndLoginProcess

  before_action :set_interaction
  before_action :set_user, only: :verify_phone
  skip_before_action :user_authorize!, only: :verify_phone
  skip_before_action :check_sign_up_status, only: :update

  def update
    old_state = current_user.state
    outcome = interact_with_user(current_user)
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    return render json: {
      from: old_state,
      to: current_user.state,
      user: UserSerializer.new(current_user, include: [], scope_name: 'current_user')
    }
  end

  def verify_phone
    outcome = interact_with_user(@user)
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    return render_success_response(I18n.t('users.phone.verification.success')) unless params[:authenticate]
    sign_in(validate_password: false)
  end

  private

  def set_interaction
    @interaction = User::ONBOARDING_INTERACTION_MAP[params[:user_action]]
    render_error_response('Invalid user action') unless @interaction 
  end

  def set_user
    @user = User.where(phone: params[:phone]).or(
      User.where(unverified_phone: params[:phone])
    ).take
    return render_not_found_response(I18n.t('users.not_found')) if @user.blank?
  end

  def interact_with_user(user)
    @interaction.run(user_params.merge(user: user))
  end

  def user_params
    params.fetch(:user, {}).permit(
      :first_name, :last_name, :date_of_birth, :password,
      :phone, :street_address, :state, :city, :zip_code
    ).merge(phone_verification_params)
     .merge(extra_details)
  end

  def phone_verification_params
    params.permit(:otp, :token)
  end

  def extra_details
    params.permit(:currency, :password)
  end
end
