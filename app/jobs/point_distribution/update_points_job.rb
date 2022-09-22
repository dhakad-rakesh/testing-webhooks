class PointDistribution::UpdatePointsJob < ApplicationJob
  def perform(wallet_id)
    wallet = Wallet.find_by(id: wallet_id)
    wallet.available_amount += 1000
    wallet.save
  end
end
