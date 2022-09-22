module Extensions
  module User
    module WalletManagement
      extend ActiveSupport::Concern

      def point_wallet
        wallets.find_by(wallet_type: :point)
      end

      def reseller_wallet
        wallets.find_by(wallet_type: :reseller)
      end

      def currency_wallet
        wallets.find_by(wallet_type: :currency)
      end

      def current_wallet
        wallet = wallets.find_by(is_current: true)
        return wallet if wallet.present?
        create_associated_wallets if wallets.blank?
        wallet = wallets.first
        wallet.update(is_current: true) && wallet
      end

      def create_associated_wallets
        Constants::COMPULSORY_WALLET_TYPES.each do |key|
          wallet = wallets.find_or_create_by(wallet_type: key)
          #next if wallet.persisted?
          #wallet.update(available_amount: Constants.const_get("#{key.upcase}_WALLET_JOINING_AMOUNT"))
        end
        wallets
      end

      def create_currency_wallet!(currency)
        wallets.create(wallet_type: :currency, currency: currency, is_current: true) 
      end

      def wallets_detail
        wallets.point
      end
    end
  end
end
