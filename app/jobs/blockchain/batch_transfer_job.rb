# Batch transfer of token funds from all the user’s deposit addresses to the admin’s address
class Blockchain::BatchTransferJob < ApplicationJob
  queue_as :default

  def perform
    data = []
    User.available.each do |user|
      data << {"id": user.id.to_s}
    end
    client.post('batchTransfer', { users: data })
  end

  private

  def client
    @client ||= Metamask::Client.new
  end

end
