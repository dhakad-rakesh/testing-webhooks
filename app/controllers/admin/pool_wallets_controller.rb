class Admin::PoolWalletsController < Admin::BaseController
  skip_load_and_authorize_resource

  def index
    @balance = get_balance.to_f
    @ledgers = Ledger.manual_transfers.debit.order_by_recent
                .paginate(per_page: Constants::PER_PAGE, page: params[:page])
  end

  def transfer
  begin
    ActiveRecord::Base.transaction do
      create_ledger
      # @ledger.update!(tracking_id: "Ledger-#{@ledger.id}")
      response = client.post('withdraw', transfer_params)
      data = JSON.parse(response.body)
      if data['success']
        @ledger.update(tracking_id: data['data']['transactionHash']) if data['data']['transactionHash'].present?
        flash[:success] = 'Amount transferred successfully' 
      else
        flash[:error] = 'Amount transferred failed'
        raise ActiveRecord::Rollback
      end
    end
  rescue Exception => e
    flash[:error] = t('went_wrong')
  end
  redirect_to admin_admin_user_pool_wallets_path(current_admin_user)
  end

  def withdraw_all
  begin
    response = client.post('withdrawAll')
    data = JSON.parse(response.body)
    if data['success']
      flash[:success] = 'Amount withdrawed successfully' 
    else
      flash[:error] = 'Amount withdraw failed'
    end
  rescue Exception => e
    flash[:error] = t('went_wrong')
  end
  redirect_to admin_admin_user_pool_wallets_path(current_admin_user)
  end

  # def normal_user_withdraw
  # begin
  #   Metamask::TransferLostAmountJob.perform_now
  #   flash[:success] = 'Amount withdrawal request sent to the blockchain successfully'
  # rescue Exception => e
  #   flash[:error] = 'Amount withdraw failed'
  # end
  # redirect_to admin_admin_user_pool_wallets_path(current_admin_user)
  # end

  private

  def create_ledger
    @ledger = transaction.user.current_wallet.ledgers.create!(
      amount: transaction.amount,
      betable: transaction.user,
      transaction_type: 'debit',
      mode: transaction.method,
      status: 'initiated',
      account_details: transaction.receiver,
      remark: "Manual transfer for #{'%.10f' % transaction.amount}"
    )
  end

  def transaction
      ::Payments::Transactions::Payout.new(
        user: current_admin_user,
        amount: allow_trasfer_params[:amount].to_f,
        receiver: allow_trasfer_params[:reciever_address]
      )
  end

  def client
    @client ||= Metamask::Client.new
  end

  def get_balance
    response = client.get('getBalance', { address: Figaro.env.POOL_WALLET_ADDRESS})
    data = JSON.parse(response.body)
    data.dig('data', 'token', 'balance')
  rescue Exception => e
    return 0
  end

  def allow_trasfer_params
    params.permit(:reciever_address, :amount)
  end

  def transfer_params
   {
    "receiverAddress": allow_trasfer_params[:reciever_address],
    "amount": allow_trasfer_params[:amount].to_f,
    "ledgerId": @ledger.id
    }
  end 
end
