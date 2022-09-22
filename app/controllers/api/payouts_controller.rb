class Api::PayoutsController < Api::BaseController
  before_action :verify_status, only: :create
  # TODO: Update lock here to be blocking and handle simultaneous withdrawal requests
  def create
    lock_name = "withdrawal_lock_#{current_user.id}"
    Rails.logger.info "Processing withdrawal with lock: #{lock_name}"
    outcome = RedisMutex.with_lock(lock_name, block: 0) do
                Payments::RequestPayout.run(payout_params.merge(user: current_user))
              end
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    #render_success_response(outcome.result)
    NotificationMailer.withdraw_request(current_user.admin_user, current_user, payout_params[:amount]).deliver_later
    render json: { message: I18n.t('messages.payout.pending') }
  rescue RedisMutex::LockError
    Rails.logger.error "Failed to acquire withdrawal lock: #{lock_name}"
    render_error_response(I18n.t('errors.messages.failed_to_acquire_lock'))
  end

  def available_methods
    available_methods = ::Payments::Payout::PAYMENT_METHODS
    return render_partial_success_response(I18n.t('methods.withdrawal.not_found')) if available_methods.blank?
    render json: available_methods
  end

  def payout_params
    params.permit(:amount, :deposit_address)
    # params.permit(:amount, :currency, :payment_method, :receiver_mobile)
  end

  def verify_status
    return(render_error_output('Please get your KYC verification complete')) unless current_user.kyc_status == 'Approved'
    return(render_error_output('Please get your two factor authentication complete')) unless current_user.two_factor_authentication.present?    
  end
end
