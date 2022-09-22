# User will have multiple wallets and only one wallet will be current_wallet.
# All amount always will be deducted from current_wallet.
class Wallet < ApplicationRecord
  # When added any new wallet_type add joining amount in constant as well.
  # We provide some joining amount when user is created
  enum wallet_type: { point: 0, currency: 1, betting_pool: 2, reseller: 4 }

  enum currency: {
    USD: 0
  }

  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :by_users, ->(ids) { where(usable_id: ids) }

  # Ledgers is transaction history
  has_many :ledgers # rubocop:disable Rails/HasManyOrHasOneDependent
  belongs_to :usable, polymorphic: true

  validate :currency_change, if: :currency_changed?

  after_save :broadcast_updated_balance

  def credit(amount, withdrawable: true, cashback_type: nil)
    amount = amount.to_f
    self.available_amount += amount
    if cashback_type.eql?('betting')
      self.betting_bonus += amount
    elsif cashback_type.eql?('casino')
      self.casino_bonus += amount
    end
    self.withdrawable_amount += amount if withdrawable
    save!
  end

  # Deduct amount from wallet
  def debit(amount)
    amount = amount.to_f
    return false if self.available_amount < amount

    self.available_amount -= amount
    self.withdrawable_amount -= amount
    save!
  end

  def debit_from_bonus(amount)
    self.losing_bonus_amount -= amount
    save!
  end

  # Use this method to get the correct amount
  def amount
    available_amount - blocked_amount
  end

  def bonus
    available_amount - withdrawable_amount
  end

  # Created for distinguishing available betting and casino amounts

  def total_available_amount(bonus_type:)
    if bonus_type.eql?('betting')
      withdrawable_amount + betting_bonus
    elsif bonus_type.eql?('casino')
      withdrawable_amount + casino_bonus
    else
      available_amount
    end
  end

  # def casino_available_amount
  #   withdrawable_amount + casino_bonus
  # end

  # def betting_available_amount
  #   withdrawable_amount + betting_bonus
  # end

  def blocked_amount
    ledgers.where(
      betable_type: 'User',
      transaction_type: 'debit',
      status: Ledger::PENDING
    ).sum(:amount)
  end

  def self.wallet_details(wallets)
    wallets.inject({}) { |r, wallet| r.merge(wallet.wallet_type => wallet.amount) }
  end

  def currency_change
    errors.add(:wallet, 'is not empty, currency cannot be changed') unless available_amount.zero?
  end

  def latest_credit
    ledgers.order_by_recent.where(betable_type: 'User', transaction_type: :credit).limit(1).pluck(:amount)&.first
  end

  def latest_debit
    ledgers.order_by_recent.where(betable_type: 'User', transaction_type: :debit).limit(1).pluck(:amount)&.first
  end

  def broadcast_updated_balance
    UserBalanceChannel.broadcast_to(
      self.usable,
      { balance: self.available_amount }
    )
  end
end
