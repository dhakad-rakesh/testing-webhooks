class Admin::TransferFundsController < Admin::BaseController
  skip_load_and_authorize_resource
  before_action :set_admin , only: :manaul_transfer
  before_action :set_ledger, only: :retry_request
  
  def manaul_transfer
    status, message = Blockchain::ManualTransfer.new(@admin_user, manual_transfer_params[:amount], manual_transfer_params[:wagered_amount]).call
    status ? flash[:success] = message : flash[:error] = message
    redirect_to admin_admin_user_path(@admin_user)
  end

  def retry_request
    response = client.post('transfer', transfer_api_params)
    data = JSON.parse(response.body)
    if data['success']
      @ledger.initiated!
      flash[:success] = 'Amount transferred request initiated successfully'
    else
      flash[:error] = 'Amount transferred failed from blockchain'
    end
    
    redirect_to root_path
  end

  private

  def set_admin
    @admin_user = AdminUser.find_by(id: manual_transfer_params[:admin_user_id])
  end

  def set_ledger
    @ledger = Ledger.find_by(id: retry_params[:ledger_id])
  end

  def manual_transfer_params
    params.permit(:admin_user_id, :amount, :wagered_amount)
  end

  def retry_params
    params.permit(:ledger_id)
  end

  def transfer_api_params
    {
      "receiverAddress": @ledger.account_details,
      "amount": @ledger.amount.to_f,
      "ledgerId": @ledger.id
    }
  end

  def client
    @client ||= Metamask::Client.new
  end
end
