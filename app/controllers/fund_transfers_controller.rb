class FundTransfersController < BaseController
  layout 'user_theme'
  before_action :set_payee, only: [:get_user_details, :initiate_transfer]
  before_action :initialize_attributes, :check_transfer_limit, only: :initiate_transfer
  before_action :set_user_ledgers, only: :transaction_history

  def index
    @frequent_payees = current_user.frequent_payees
  end

  def get_user_details; end

  def initiate_transfer
    @status, @message = fund_transfer_process
    @balance = current_user.available_amount
  end

  def manual_transfer
  end

  def transaction_history
    transaction_history = unless params[:category].present?
                            @user_ledgers
                          else
                            @user_ledgers.where(betable_type: params[:category])
                          end
    transaction_history = transaction_history.between(params[:min_date].to_date, params[:max_date].to_date) if params[:min_date].present? && params[:max_date].present?
    @transaction_history = transaction_history.order_by_recent.paginate(page: params[:page], per_page: params[:per_page] || 10)
  end

  private
  
  def fund_transfer_process
    FundTransferProcess.new(payor: @payor, payee: @payee, amount: @amount).call
  end

  def set_payee
    @errors = []
    @payee = User.find_by_username params[:username]
    if @payee.blank?
      @errors << "Payee not found." 
    else
      @errors << "Can't pay to yourself." if @payee.id == current_user.id
      @errors << "Payee is not verified." unless @payee.enabled?
    end
    render params[:action] if @errors.any?
  end

  def initialize_attributes
    @amount = params[:amount]
    @payor = current_user
    @errors = []
    @errors << "Please enter valid amount." if @amount.to_f < 1
    render params[:action] and return if @errors.any?
  end

  def set_user_ledgers
    @user_ledgers = current_user.ledgers
  end

  def check_transfer_limit
    amount_transferred_today = TransferRecord.paid_by(current_user).between(Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).sum(:amount)
    if (@amount.to_f + amount_transferred_today) > GammabetSetting.fund_transfer_limit
      @errors << "Daily limit reached. You can transfer only #{NumberService.round_to_8_decimal(GammabetSetting.fund_transfer_limit - amount_transferred_today)} today."
    end
    render params[:action] and return if @errors.any?
  end
end
