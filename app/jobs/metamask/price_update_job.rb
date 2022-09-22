class Metamask::PriceUpdateJob < ApplicationJob
  queue_as :default

  def perform
    client.post('updatePrice', params)
  end

  private

  def client
    @client ||= Metamask::Client.new
  end

  def params
    {
    "url": Figaro.env.COIN_BASE_URL,
    "priceObject": "price"
    }
  end
end
