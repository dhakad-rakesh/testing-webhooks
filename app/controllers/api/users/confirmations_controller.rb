class Api::Users::ConfirmationsController < Api::BaseController
  include Api::RegistrationAndLoginProcess
  skip_before_action :user_authorize!, only: %I[create show]
  before_action :set_user, only: :create

  # resend confirmation instructions
  def create
    @user.send_confirmation_instructions
    return render_error_response(@user.errors.full_messages.first) if @user.errors.any?
    render_success_response(I18n.t(:confirmation_mail_sent))
  end

  def show
    @user = User.confirm_by_token(params[:confirmation_token])
    return render_error_response(@user.errors.full_messages.first) unless @user.errors.empty?
    sign_in(validate_password: false)
  end

protected

  def set_user
    @user = User.where(email: params[:email]&.downcase).or(
      User.where(unconfirmed_email: params[:email])
    ).take
    render_error_response('User not found') unless @user
  end
end
