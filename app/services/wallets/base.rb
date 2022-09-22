module Wallets
  class Base
    include Utility::PublishWallet
    attr_reader :wallet

    def initialize(wallet)
      @wallet = wallet
    end

    # Add amount to wallet
    def credit(amount, bonus_amount: 0.0)
      return 0 if wallet.available_amount >= GammabetSetting.user_wallet_limit
      
      amount = amount.to_f
      remaining_limit = GammabetSetting.user_wallet_limit - wallet.available_amount.to_f
      if amount <= remaining_limit
        wallet.available_amount += amount
        wallet.withdrawable_amount += amount
      else
        wallet.available_amount += remaining_limit
        wallet.withdrawable_amount += amount
        amount = remaining_limit
      end
      wallet.available_amount += bonus_amount
      wallet.betting_bonus += bonus_amount
      publish_wallet(wallet)
      wallet.save
      (amount + bonus_amount)
    end

    # Deduct amount from wallet
    def debit(amount, bonus_type: 'betting', check_available_amount: true)
      # modify according to available amount only of game type
      amount = amount.to_f
      return false if check_available_amount && wallet.total_available_amount(bonus_type: bonus_type) < amount

      wallet.withdrawable_amount -= withdrawable_debit_amount(amount, bonus_type: bonus_type)
      wallet.available_amount -= amount
      wallet.wagered_amount += amount
      publish_wallet(wallet)
      wallet
    end

    # TODO: Refactor
    def withdrawable_debit_amount(amount, bonus_type:)
      bonus = bonus_type.eql?('casino') ? wallet.casino_bonus : wallet.betting_bonus
      if amount <= bonus
        if bonus_type.eql?('casino')
          wallet.casino_bonus -= amount
        elsif bonus_type.eql?('betting')
          wallet.betting_bonus -= amount
        end
        0.0
      else
        if bonus_type.eql?('casino')
          wallet.casino_bonus = 0
        elsif bonus_type.eql?('betting')
          wallet.betting_bonus = 0
        end
        (amount - bonus)
      end
    end

    # This method is created seperately because betting structure takes multiple
    # bets. For each bet we are not going to trigger any save on database so
    # we reduce the amount but do not call save on wallet.
    # So at last we will trigger save to avoid database transactions.
    def persist_wallet!
      wallet.save!
    end
  end
end
