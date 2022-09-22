class PromoCode < ApplicationRecord
  store :settings, coder: Hash, accessors: %I[threshold_amount maximum_cashback]

  ALPHA_REGEX = /\A[a-zA-Z]*\z/.freeze
  ALPHANUM_REGEX = /\A[a-zA-Z0-9]*\z/.freeze
  
  has_many :user_promo_codes
  has_many :users, through: :user_promo_codes

  validates :percent, :threshold_amount, :maximum_cashback, presence: true
  validates :code, presence: true, uniqueness: true, :format => { with: ALPHANUM_REGEX, :message => "must not have special characters." }
  validates :name, presence: true, :format => { with: ALPHA_REGEX, :message => "must be alphabetic only." }

  # validate :valid_promo_dates
  
  # def valid_promo_dates
  #   errors.add(:valid_till, :greater_or_equal) if valid_from > valid_till
  # end

  FIXED_VALUE = 'fixed_value'
  PERCENTAGE = 'percentage'

  INACTIVE = 'inactive'
  ACTIVE = 'active'
  EXPIRED = 'expired'

  BETTING = 'betting'
  CASINO = 'casino'

  KINDS = {
    FIXED_VALUE => 0,
    PERCENTAGE => 1
  }

  STATUSES = {
    INACTIVE => 0,
    ACTIVE => 1,
    EXPIRED => 2
  }

  PROMO_TYPES = {
    BETTING => 0,
    CASINO => 1
  }

  enum kind: KINDS
  enum status: STATUSES
  enum promo_type: PROMO_TYPES

  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }
  scope :expiring_between, ->(start_date, end_date) { where(valid_till: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }

  def available_for_user(user)
    return true unless limit_per_user.present?
    user_promo_codes.where(user_id: user.id).count < limit_per_user
  end

  def details(currency)
    {
      id: id,
      code: code,
      kind: kind,
      promo_type: promo_type,
      percent: percent,
      threshold_amount: threshold_amount[currency],
      maximum_cashback: maximum_cashback[currency]
    }
  end

  def current_usage
    user_promo_codes.reserved.count
  end

  def limit_exhausted?
    return false unless usage_limit.present?
    current_usage >= usage_limit
  end
end
