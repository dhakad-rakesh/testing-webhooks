class Metamask::BlockchainUpdateJob < ApplicationJob
  queue_as :high

  def perform(api, params)
    client.post(api, params)
  end

  private

  def client
    @client ||= Metamask::Client.new
  end
end
