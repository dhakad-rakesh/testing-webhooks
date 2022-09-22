# Ledgers is transaction history
class Ledger < ApplicationRecord  
  belongs_to :wallet
  belongs_to :source_wallet, class_name: "Wallet",  foreign_key: :source_wallet_id, optional: true
  belongs_to :betable, polymorphic: true, optional: true
  belongs_to :session_transaction, foreign_key: :transaction_id, optional: true, primary_key: :transaction_id
  belongs_to :user_promo_code, optional: true
  belongs_to :transfer_record, optional: true
  belongs_to :admin_user, optional: true

  after_create :notify_admin

  # enum transaction_type: { credit: 0, debit: 1, refund: 2, deposit_by_agent: 3, withdraw: 4, bet: 5, win: 6, bet_losing_bonus: 7,
  #                          win_losing_bonus: 8, refund_losing_bonus: 9, claim_losing_bonus: 10, claim_deposit_bonus: 11,
  #                          bonus_deposit_by_admin: 12, bonus_withdraw_by_admin: 13, deposit_by_player: 14 }
                           
  TRANSACTION_TYPES = {
    DEBIT = 'debit' => 0,
    CREDIT = 'credit' => 1,
    REFUND = 'refund' => 2,
    BET = 'bet' => 3,
    WITHDRAW = 'withdraw' => 4,
    WIN = 'win' => 5
  }
  
  enum transaction_type: TRANSACTION_TYPES
  has_secure_token :tracking_id
  has_many :users_ledger, through: :ledgers, source: :betable, source_type: 'User'

  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :unapproved, -> { where(approved: false) }
  scope :players_ledgers, -> { where.not(betable_type: ['AdminUser', 'User']) }
  scope :admin_ledgers, -> { where(betable_type: 'AdminUser') }
  scope :affiliate_ledgers, -> (ids) { where(betable_id: ids, betable_type: 'AdminUser') }
  scope :search, -> (query) { where(transaction_type: query.downcase) }
  scope :search_by_amount, -> (min, max) { where(amount: (min..max)) }
  scope :withdrawal_requests, -> { debit.where(betable_type: 'User', status: [PENDING, APPROVED, REJECTED, INITIATED]) }
  scope :manual_transfers, -> { where(betable_type: 'AdminUser', status: [PENDING, APPROVED, REJECTED, INITIATED]) }
  scope :deposits_requests, -> { credit.where(betable_type: 'User', status: [PENDING, APPROVED, REJECTED]) }
  scope :credit, -> { where(transaction_type: 'credit') }
  scope :debit, -> { where(transaction_type: 'debit') }

  scope :deposits, -> { deposit_transactions.where(status: [INITIAL, SUCCEEDED, APPROVED], kind: DEFAULT) }
  scope :withdrawals, -> { withdrawal_transactions.where(status: [INITIAL, SUCCEEDED, APPROVED], kind: DEFAULT) }
  scope :transactions, -> { where(status: [INITIAL, SUCCEEDED, APPROVED], betable_type: 'User', kind: DEFAULT) }
  scope :by_betable, ->(betable_type, betable_id) { where(betable_type: betable_type, betable_id: betable_id) }
  scope :deposit_transactions, -> { credit.where(betable_type: 'User') }
  scope :withdrawal_transactions, -> { debit.where(betable_type: 'User') }
  scope :betting_transactions, -> { where(betable_type: ['Bet', 'ComboBet']) }
  scope :user_transactions, -> { where(betable_type: ['User', 'AdminUser']) }
  scope :unsettel_withdrawal_transactions, -> {withdrawal_transactions.where.not(tracking_id: nil).where(status: Ledger::UNSETTEL_STATUSES)}
  scope :inner_join_user_address, -> { joins('INNER JOIN wallets
                                        ON wallets.id = ledgers.wallet_id
                                        INNER JOIN users
                                        ON users.id = ledgers.betable_id'
                                        )
                                      }
  
  scope :inner_join_users, -> { joins('INNER JOIN wallets
                                        ON wallets.id = ledgers.wallet_id
                                        INNER JOIN users
                                        ON users.id = wallets.usable_id')
                                      }

  scope :total_cashback_bonus, -> { joins(:user_promo_code).where(user_promo_codes: { status: :succeeded }).sum(:cashback_value) }
  scope :total_referral_bonus, -> { referral_transactions.sum(:amount) }
  # scope :bets_bonus_amount, -> { betting_transactions.bonus.sum(:bonus_amount) }
  scope :search_by_region, ->(country) { where(addresses: { country: country }) }
  scope :by_users, ->(ids) { where(betable_id: ids) }

  scope :daily_deposit, -> { deposits.between(Time.zone.now.beginning_of_day, Time.zone.now).sum(:amount) }
  scope :weekly_deposit, -> { deposits.between(Time.zone.now.beginning_of_week, Time.zone.now).sum(:amount) }
  scope :monthly_deposit, -> { deposits.between(Time.zone.now.beginning_of_month, Time.zone.now).sum(:amount) }
  scope :todays_ledgers, -> { between(Time.zone.now.beginning_of_day, Time.zone.now) }
  scope :filter_from_amount, ->(amount) {
    where('amount >= ?', amount)
  }

  scope :filter_to_amount, ->(amount) {
    where('amount <= ?', amount)
  }

  scope :referral_transactions, -> { where(kind: REFERRAL_REWARD) }
  scope :cashback_transactions, -> { deposit_transactions.where(kind: CASHBACK) }
  scope :bonus_transactions, -> { where(kind: BONUS) }

  INITIAL = 'initial'
  PENDING = 'pending'
  SUCCEEDED = 'succeeded'
  FAILED = 'failed'
  CANCELLED = 'cancelled'
  APPROVED = 'approved'
  REJECTED = 'rejected'
  PROCESSING = 'processing'
  INITIATED = 'initiated'

  INTERNAL = 'internal'
  CASHIER = 'cashier'
  FAST_PAY = 'fast_pay'
  ADMIN = 'admin'
  MANUAL = 'manual'
  
  DEFAULT = 'default'
  REFERRAL_REWARD = 'referral_reward'
  CASHBACK = 'cashback'
  BONUS = 'bonus'

  BETTING = 'betting'
  CASINO = 'casino'

  STATUSES = {
    INITIAL => 0,
    PENDING => 1,
    SUCCEEDED => 2,
    FAILED => 3,
    CANCELLED => 4,
    REJECTED => 5,
    APPROVED => 6, 
    INITIATED => 7,
    PROCESSING => 8

  }

  KINDS = {
    DEFAULT => 0,
    REFERRAL_REWARD => 1,
    CASHBACK => 2,
    BONUS => 3
  }

  PROCESSED_STAUSES = [SUCCEEDED, APPROVED, FAILED, CANCELLED]

  UNSETTEL_STATUSES =   [INITIATED]

  enum status: STATUSES
  enum kind: KINDS
  enum cashback_type: {
    BETTING => 0,
    CASINO => 1
  }

  enum mode: {
    INTERNAL => 0,
    CASHIER => 1,
    FAST_PAY => 2,
    ADMIN => 3,
    MANUAL => 4
  }

  def register_cancellation!(message)
    Ledger.transaction do
      update!(status: 'cancelled', remark: message)
      user_promo_code.failed! if cashback?
    end
  end

  def register_failure!(message)
    Ledger.transaction do
      update!(status: 'failed', remark: message)
      user_promo_code.failed! if cashback?
    end
  end

  def register_success!(message, status: 'initiated')
    Ledger.transaction do
      update!(status: status.presence || 'initiated', remark: message)
      # wallet.public_send(transaction_type, amount)
      # if cashback?
      #   wallet.public_send(transaction_type, cashback_amount, withdrawable: false, cashback_type: cashback_type)
      #   user_promo_code.succeeded!
      # end
    end
  end

  def register_rejection!(message)
    Ledger.transaction do
      update!(status: 'rejected', remark: message)
      refund_ledger
    end
  end

  def processed?
    PROCESSED_STAUSES.include?(status)
  end

  def register_bet_cancellation!(message)
    Ledger.transaction do
      update!(status: 'succeeded', remark: message)
      wallet.public_send(transaction_type, amount)
    end
  end

  def cashback_amount
    return unless cashback?
    user_promo_code.cashback_value
  end

  def notify_admin
    return unless betable_type == 'User'
    Notifications::PublishNotificationJob.perform_later(self.id, notification_type)
  end

  def notification_type
    if credit?
      Constants::NOTIFICATION_KIND[:deposit_request]
    else
      Constants::NOTIFICATION_KIND[:withdrawal_request]
    end
  end

  def refund_ledger
    ledger = wallet.ledgers.create!(
      amount: amount,
      betable: betable,
      transaction_type: 'credit',
      status: 'succeeded',
      remark: "Refund for withdraw request of #{amount}"
    )
    ledger.wallet.public_send(ledger.transaction_type, amount)
  end

  class << self

    def to_csv
      attributes = ["ID", "Amount", "DateTime", "Type", "Remark", "Payment System"]

      CSV.generate(headers: true) do |csv|
        csv << attributes
        
        all.each do |ledger|
          csv << [ledger.id, ledger.amount, ledger.created_at.in_time_zone('Moscow')&.strftime('%e %b %Y, %H:%M %a'), ledger.transaction_type, ledger.remark, ledger.mode&.humanize || "NA"] 
        end
      end
    end

    def all_ledgers_of_admin(admin)
      where(
        "(betable_type = 'AdminUser' AND betable_id = ?) OR (betable_type = 'User' AND betable_id IN (?))",
        admin.id,
        admin.users.ids
      )
    end

    def monthly_income
      current_month_ledgers = between(Time.zone.now.beginning_of_month, Time.zone.now)
      current_month_ledgers.total_income
    end

    def today_income
      todays_ledgers.total_income
    end


    def total_income
      #total dr from users - total cr to users
      debit.pluck(:amount).sum - credit.pluck(:amount).sum
    end

    def reseller_ledgers(admin_user)
      players_ledgers.joins(:wallet).where("wallets.usable_id in (?) and wallets.usable_type = ?", admin_user.users.pluck(:id), "User")
    end

    def total_bonus_amount
      total_referral_bonus + total_cashback_bonus
    end
  end
end
