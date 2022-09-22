# To Transfer users lost balance amount(lost in bet) from users blockchain account to admin account 
class Metamask::TransferLostAmountJob < ApplicationJob
  queue_as :high

  def perform
    data = []
    User.normal.available.each do |user|
      next unless user.deposit_key
      data << params(user)
    end
    client.post('batchTransfer', { users: data })
  end

  private

  def client
    @client ||= Metamask::Client.new
  end

  def params(user)
    {
      "privateKey": user.deposit_key,
      "balance": user.available_amount
    }
  end
end
