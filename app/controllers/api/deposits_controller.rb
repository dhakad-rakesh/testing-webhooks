class Api::DepositsController < Api::BaseController
  skip_before_action :user_authorize!, only: %I[metamask_deposit transaction]
  before_action :set_user, only: %I[metamask_deposit transaction]

  def metamask_deposit
    # # outcome = Payments::MetamaskDeposit.run(metamask_deposit_params.merge(user: @user))
    # outcome = Payments::RequestDeposit.run(metamask_deposit_params.merge(user: @user))
    # return render_error_output(outcome.errors.full_messages.first) unless outcome.valid?
    # ::Users::CreditDepositBonusJob.perform_later(@user) if @user.deposit_bonus_applicable?(metamask_deposit_params[:amount].to_f)
    # credit_referral_amount unless @user.amount_credited_to_referrer?
    # render json: {success: true}
  end

  def transaction
    outcome = Payments::RequestDeposit.run(metamask_deposit_params.merge(user: @user))
    return render_error_output(outcome.errors.full_messages.first) unless outcome.valid?
    ::Users::CreditDepositBonusJob.perform_later(@user) if @user.deposit_bonus_applicable?(metamask_deposit_params[:value].to_f)
    credit_referral_amount unless @user.amount_credited_to_referrer?
    render json: {action: 'DEPOSIT', userId: @user.id.to_s}
  end


  def generate_deposit_address
    response = client.post('deployUserContract', address_params)
    return error_response if response.try(:code) != '200'
    data = JSON.parse(response.body)
    if data['success']
      # current_user.update(deposit_address: data.dig('data', 'newContractAddress'))
      # return render json: {deposit_address: data.dig('data', 'newContractAddress')}
      current_user.update(deposit_address_request: true)
      return render json: {success: true}
    end
    # if current_user.update(deposit_address_request: true)
    #   Metamask::BlockchainUpdateJob.perform_later('deployUserContract', address_params)
    #   render json: {success: true}
    # else
      error_response
  end

  def create
    outcome = Payments::RequestDeposit.run(deposit_params.merge(user: current_user))
    return render_error_output(outcome.errors.full_messages) unless outcome.valid?
    # render json: { payment_page_url: outcome.result }
    render json: { message: I18n.t('messages.deposit.success') }
  end

  def available_methods
    available_methods = ::Payments::Deposit::PAYMENT_METHODS
    return render_partial_success_response(I18n.t('methods.deposit.not_found')) if available_methods.blank?
    render json: available_methods
  end

  def deposit_params
    params.permit(:amount, :currency, :payment_method, :promo_code)
  end

  def metamask_deposit_params
    params.permit(:value, :receiver, :sender, :transactionHash)
  end

  def set_user
    render json: {action: 'IGNORE'} and return if metamask_deposit_params[:receiver].eql?(Figaro.env.POOL_WALLET_ADDRESS)
    # render json: {action: 'IGNORE'} and return if metamask_deposit_params[:receiver] == Constants::ADMIN_BLOCKCHAIN_ADDRESS
    @user = User.find_by(deposit_address: metamask_deposit_params.dig(:receiver)&.downcase )
    return render_error_output(I18n.t('users.not_found')) unless metamask_deposit_params[:receiver] && @user
  end

  def client
    @client ||= Metamask::Client.new
  end

  def address_params
    {"name": current_user.username}
   # {"name": current_user.username,
   #  "userSettingsContractAddress": Figaro.env.CONTRACT_ADDRESS,
   #  "poolWalletAddress": Figaro.env.POOL_WALLET_ADDRESS}
  end

  def error_response
    render_error_response('Fail to generate deposit address')
  end

  def credit_referral_amount
    return unless @user.eligible_to_credit_referrer?
    ::Users::CreditReferralAmountJob.perform_later(@user.id)
  end
end
