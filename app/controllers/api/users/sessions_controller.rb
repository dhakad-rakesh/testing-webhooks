# Handles current user sessions resources actions.
class Api::Users::SessionsController < Api::BaseController
  include Api::RegistrationAndLoginProcess
  skip_before_action :user_authorize!, only: %I[create]
  before_action :set_user, only: %I[create]
  skip_before_action :check_sign_up_status, only: %I[destroy]

  def create
    sign_in(validate_password: !current_user.present?)
  end

  def destroy
    current_user.update(login_token: nil)
    doorkeeper_token.destroy  
    remove_device_id(params[:device_id])
    render_success_output(I18n.t('users.sign_out'))
  end

  private

  def set_user
    # return @user = current_user if current_user.present?
    # @user = User.kept.where(phone: params[:login]).first
    @user = 
      if params[:username].present?
        name = params[:username].downcase
        User.kept.where(username: name).first
      elsif current_user
        current_user
      end
    return render_not_found_response(I18n.t('users.not_found')) if @user.blank?
  end

  def remove_device_id(id)
    Rails.logger.info "Logging out: user_id #{current_user.id} device_id: #{id}"
    return unless id.present?
    ::Users::UpdateDeviceIdJob.perform_later(current_user.id, old_device_id: id)
  end
end
