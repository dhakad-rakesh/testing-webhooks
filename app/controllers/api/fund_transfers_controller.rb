class Api::FundTransfersController < Api::BaseController
  before_action :set_payee, only: [:get_user_details, :create]
  before_action :initialize_attributes, :check_transfer_limit, only: :create
  before_action :set_user_ledgers, only: :transaction_history

  def get_user_details
    payee = @payee.attributes.slice('id', 'first_name', 'last_name', 'username', 'email')
    render json: { payee: payee }
  end

  def create
    status, message = fund_transfer_process
    render json: { status: status, message: message }
  end

  private
  
  def fund_transfer_process
    FundTransferProcess.new(payor: current_user, payee: @payee, amount: @amount).call
  end

  def set_payee
    @payee = if params[:action] === 'create'
      User.find_by(id: params[:id])
    else
      User.find_by(username: params[:username])
    end

    errors = []
    unless @payee.present?
      errors << "User not found."
    else
      errors << "User can't pay to self." if @payee === current_user
      errors << "Payee is not verified." unless @payee.enabled?
    end

    render json: { errors: errors } unless errors.blank?
  end

  def initialize_attributes
    @amount = params[:amount]
  end

  def set_user_ledgers
    @user_ledgers = current_user.ledgers
  end

  def check_transfer_limit
    errors = []
    amount_transferred_today = TransferRecord.paid_by(current_user).between(Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).sum(:amount)
    if (@amount.to_f + amount_transferred_today) > GammabetSetting.fund_transfer_limit
      errors << "Daily limit reached. You can transfer only #{NumberService.round_to_8_decimal(GammabetSetting.fund_transfer_limit - amount_transferred_today)} today."
    end
    render json: { errors: errors } if errors.any?
  end
end