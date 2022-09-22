class Api::Users::PasswordsController < Api::BaseController
  skip_before_action :user_authorize!, only: %I[create update mobile_token send_forget_password_otp confirm_forget_password]
  before_action :set_user, only: %I[create mobile_token]
  before_action :set_user_by_email, only: %I[confirm_forget_password send_forget_password_otp]
  before_action :validate_forget_password, only: [ :confirm_forget_password ]
  include Api::RegistrationAndLoginProcess

  def create
    @user.send_reset_password_instructions
    render_success_response(t('users.password.instructions_sent', email: @user.email))
  end

  def update
    outcome = User::ResetPasswordIntr.run(password_params)
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    render_success_response(t('users.password.reset_success'))
  end

  def mobile_token
    outcome = Onboarding::CompletePhoneVerificationIntr.run(phone_params)
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    token = @user.send(:set_reset_password_token)
    render json: { reset_password_token: token }
  end

  def send_forget_password_otp
    status, otp = @user.generate_and_save_otp!
    sent_otp = ::Users::SendOtpMail.call(@email, otp)
    if status && sent_otp.is_a?(Integer)
      return render_response(I18n.t('users.password.otp_sent.success'), 200)
    else
      return render_response(I18n.t('users.password.otp_sent.failed'), 400)
    end
  end

  def confirm_forget_password
    otp = params[:otp]
    if @user.confirm_otp(otp)
      status = @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      return render_response(@user.error.full_messages, 400) unless status 
      sign_in
    else
      return render_response(I18n.t('users.password.otp.invalid'), 400)
    end
  end

  private

  def set_user
    @user = User.where(email: params[:email]&.downcase).or(
      User.where.not(phone: nil).where(phone: params[:phone])
    ).take
    render_not_found_response(I18n.t('users.not_found')) unless @user
  end

  def set_user_by_email
    @email = params[:email]
    return render_response(I18n.t('users.email.email_required'), 400) if @email.blank?
    @user = User.where('email = ? OR unconfirmed_email = ?',@email,@email).first if @email.present?
    return render_response(I18n.t('users.not_found'), 400) if @user.blank?
  end

  def password_params
    params.permit(:reset_password_token, :password, :password_confirmation)
  end

  def phone_params
    params.permit(:otp, :token).merge(
      user: @user,
      update_phone: false
    )
  end

  def validate_forget_password
    errors = []
    errors << I18n.t('users.password.otp.required') if params[:otp].blank?
    errors << I18n.t('users.password.required_password_and_confirmation') if params[:password].blank? || params[:password_confirmation].blank?
    errors << I18n.t('users.password.confirmation_mismatch') if params[:password] != params[:password_confirmation] && !(params[:password].blank? || params[:password_confirmation].blank?)
    return render_response(errors.join(', '), 400) unless errors.blank?
  end
end
