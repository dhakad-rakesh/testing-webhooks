class UserNotifyMailer < ApplicationMailer
  before_action :set_user, only: %I[username_changed kyc_status_changed]

  def username_changed
    send_mail(@email, "Username Changed | #{@user.username}")
  end

  def kyc_status_changed
    send_mail(@email, "KYC #{@user.kyc_status}")
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    @email = @user.email
  end
end
