class Api::UsersController < Api::BaseController
  include Api::RegistrationAndLoginProcess
  skip_before_action :user_authorize!, only: %I[deposit_allowed social_sign_in failure username_exist metamask_address_exist index update_deposit_address update_user_status update_kyc_status update_withdraw_request]
  skip_before_action :verify_authenticity_token, only: %I[social_sign_in failure index update_deposit_address update_user_status update_kyc_status update_withdraw_request]
  #skip_before_action :check_country_status
  skip_before_action :check_sign_up_status, only: :delete
  # after_action :sign_out_user, only: :delete
  before_action :check_confirm_email, only: %I[confirm_email get_email_otp]
  before_action :validate_email_uniquness, only: %I[get_email_otp]
  before_action :set_user, only: :update_kyc_status
  before_action :set_ledger, only: :update_withdraw_request
  def index
    @users = User.all.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(@users, with_wallet: true)
  end

  def failure
    render_error_response($ERROR_INFO&.message || I18n.t('en.something_went_wrong'))
  end

  def delete
    if current_user.update_with_password(user_params)
      render_success_response(I18n.t('users.delete.success'))
    else
      render_error_response(current_user.errors.full_messages.first)
    end
    current_user.destroy
  end

  def confirm_email
    otp = params[:otp]
    if current_user.confirm_otp(otp)
      current_user.email = current_user.unconfirmed_email
      current_user.unconfirmed_email = nil
      status = current_user.save
      return render_error_output(current_user.error.full_messages) unless status
      render_success_output(I18n.t('users.email.email_confirmed'))
    else
      return render_error_output(I18n.t('users.password.otp.invalid'))
    end
  end

  def get_email_otp
    status, otp = current_user.generate_and_save_otp!
    sent_otp = ::Users::SendOtpMail.call(current_user.unconfirmed_email, otp)
    if status && sent_otp.is_a?(Integer) && current_user.save!
      return render_success_output(I18n.t('users.password.otp_sent.success'))
    else
      return render_error_output(I18n.t('users.password.otp_sent.failed'))
    end
  rescue StandardError => e
    render_error_output(e.message)
  end

  def username_exist
    @user = User.find_by(username: params[:username])
    return render json: {result: {exist: true}}, status: :ok if @user
    render json: {result: {exist: false}}, status: :ok
  end

  def deposit_allowed
    return render_error(I18n.t('users.not_found')) unless current_user
    user = User.metamask.find_by(metamask_address: params[:metmask_address])
    return render_error(I18n.t('users.not_found')) unless user
    status = user.valid_for_deposit?(params[:amount])
    return render json:{ allowed: true } if status
    render_deposit_status
  end

  def update_deposit_address
    return unless params['data']
    params['data'].each do |data|
      user = User.find_by(username: data['username'])
      user.update(deposit_address: data['depositAddress']) if user.present?
    end
    render json: {success: true}
  end

  def update_user_status
    response = Blockchain::UpdateStatus.new(params).call
    render json: response
  rescue ::StandardError => exception
    render json: {success: false}
  end

  def update_kyc_status
    return error_response unless @user && @user.kyc_initiated?
    update_status
  rescue ::StandardError => exception
    error_response
  end

  def update_withdraw_request
    return error_response unless @ledger && @ledger.initiated?
    update_request
  rescue ::StandardError => exception
    error_response
  end


protected

  def update_status
    if params.dig('data', 'kycStatus')
      @user.update(kyc_status: 'Approved')
      NotificationMailer.kyc_request_status(@user).deliver_later
      return success_response
    else
      @user.update(kyc_status: 'Pending')
      return success_response
    end
  end

  def amount_difference
    return @difference_amount if @difference_amount
    transaction_fee = params.dig('data', 'transactionFees').to_f
    transaction_amount = params.dig('data', 'transactionInfo', 'amount').to_f
    return false unless (transaction_fee + transaction_amount) < @ledger.amount
    amount = @ledger.amount - (transaction_fee + transaction_amount)
    @difference_amount = amount.round(18)
end

  def update_request
    if params.dig('data', 'success')
      ActiveRecord::Base.transaction do
        @ledger.update(status: 'approved', tracking_id: params.dig('data', 'receipt', 'transactionHash'))
        if @ledger.betable_type.eql?('User') && @ledger.betable.metamask? && amount_difference
          wallet = @ledger.betable.current_wallet
          wallet.credit(amount_difference)
          wallet.ledgers.credit.create(ledger_params)
          NotificationMailer.withdraw_request_status(@ledger).deliver_later
        end
        return success_response
      end
    else
      @ledger.pending!
      return success_response
    end
    error_response
  end

  def verify_email
    current_user.assign_attributes(email: params[:email])
    current_user.valid?
  end


  def user_params
    params.permit(:current_password).merge(discarded_at: Time.now)
  end

  def sign_out_user
    return unless current_user.reload.discarded?
    sign_out current_user
    doorkeeper_token.destroy
  end

  def set_metamask_user
    @user = User.metamask.find_by(metamask_address: params[:metmask_address])
  end

  def render_deposit_status
    render json:{ allowed: false,
      kyc_status: current_user.kyc_approved?,
      two_factor_status: current_user.two_factor_authentication.present?}
  end

  def validate_email_uniquness
    @email = params[:email].to_s.downcase if params[:email].present?
    unless current_user.unconfirmed_email == @email
      user_exist = User.where('email = ? OR unconfirmed_email = ?',@email,@email).exists?
      return render_error_output(I18n.t('users.email.email_already_used')) if user_exist
    end
    current_user.assign_attributes(unconfirmed_email: @email) if @email.present?
    return render_error_output(current_user.errors.full_messages.first) unless current_user.valid?
  end

  def check_confirm_email
    return render_not_found_response(I18n.t('users.not_found')) unless current_user
    return render_error_output(I18n.t('users.email.no_email_to_verify')) if current_user.unconfirmed_email.blank? && ( action_name.include?('confirm_email') || params[:email].blank? )
  end

  def set_user
    address = params.dig('data', 'depositAddress')
    @user = User.find_by(deposit_address: address) if address
  end

  def set_ledger
    @ledger = Ledger.withdrawal_requests.find_by(id: params.dig('data', 'ledgerId'))
    return if @ledger
    @ledger = Ledger.manual_transfers.find_by(id: params.dig('data', 'ledgerId'))
  end

  def ledger_params
    {
      amount: @difference_amount,
      betable: @ledger.betable,
      transaction_type: 'credit',
      status: 'succeeded',
      remark: "Difference amount of withdraw request id- #{@ledger.id}"
    }
  end

  def error_response
    render json: {success: false}
  end

  def success_response
    render json: {success: true}
  end
end
