class Metamask::WithdrawAmountJob < ApplicationJob
  queue_as :high

  def perform(ledger)
    @ledger = ledger
    response = client.post('transfer', withdraw_params)
    return ledger.update(status: 'pending') if response.try(:code) != '200'
    data = JSON.parse(response.body)
    if data['success']
      ledger.update(status: 'approved') 
      @ledger.update(tracking_id: data['data']['transactionHash']) if data['data']['transactionHash'].present?
      NotificationMailer.withdraw_request_status(@ledger).deliver_later
    end
  end

  private

  def client
    @client ||= Metamask::Client.new
  end

  def withdraw_params
   {
    "receiverAddress": @ledger.account_details,
    "amount": @ledger.amount,
    "ledgerId": @ledger.id
    }
  end
end
