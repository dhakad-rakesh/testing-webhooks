class Admin::WithdrawalsController < Admin::BaseController
  skip_load_and_authorize_resource

  before_action :set_ledger, only: %I[confirm reject]
  
  def index
    @ledgers = Ledger.withdrawal_requests.inner_join_user_address
    filter_withdrawal_requests if query.present?
    @ledgers =  @ledgers.order_by_recent
                        .paginate(per_page: Constants::PER_PAGE, page: params[:page])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def filter_withdrawal_requests
    @ledgers = @ledgers.where(id: query[:request_id]) if query[:request_id].present?
    @ledgers = @ledgers.where('users.user_number ILIKE ?', "%#{query[:player_id].strip}%") if query[:player_id].present?
    @ledgers = @ledgers.send(query[:payment_mode]) if query[:payment_mode].present?
    @ledgers = @ledgers.between(query[:start_date].to_date, query[:end_date].to_date) if query[:filter_date].present?
  end

  def confirm
    Payments::PayoutRequestHandler.run!({
      ledger: @ledger,
      status: Ledger::APPROVED,
      remark: "Approved by #{current_admin_user.full_name}"
    })
    NotificationMailer.withdraw_request_initiate(@ledger).deliver_later
    flash[:success] = I18n.t('admin.withdrawals.initiated')
  rescue Payments::InvalidTransactionError => error
    flash[:error] = error.validation_errors.messages.first.flatten.join(': ')
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_back fallback_location: admin_withdrawals_path
  end

  def reject
    Payments::PayoutRequestHandler.run!({
      ledger: @ledger,
      status: Ledger::REJECTED,
      remark: "Rejected by #{current_admin_user.full_name}"
    })
    NotificationMailer.withdraw_request_status(@ledger).deliver_later
    render json: { message: I18n.t('admin.withdrawals.rejected'), comment: params[:comment], ledger_id: params[:ledger_id] }
  rescue StandardError => e
    render json: { message: e.message }
  end

  private

  def set_ledger
    @ledger = Ledger.find_by(id: params[:id])
    return if @ledger.blank?

    @ledger.assign_attributes(admin_user_id: current_admin_user.id, comment: params[:comment])
  end

  def query
    @query ||= params[:query]
  end
end
