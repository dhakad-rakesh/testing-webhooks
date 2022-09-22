module Utility
  module PublishWallet
    def publish_wallet(wallet)
      return unless wallet.usable_type == 'User'
      data = { wallet_id: wallet.id, amount: wallet.available_amount.round(8) }
      # UpdateUserWalletJob.perform_later(data, wallet.usable_id)
    end
  end
end