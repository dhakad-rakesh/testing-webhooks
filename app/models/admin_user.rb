class AdminUser < ApplicationRecord
  include Extensions::User::WalletManagement
  include Discard::Model
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :reseller_percentage, numericality: { greater_than: 0 }
  validate :valid_creation

  store :settings, coder: Hash, accessors: %I[commision]
  
  has_many :users
  has_many :wallets, as: :usable, dependent: :destroy
  has_many :ledgers, as: :betable, dependent: :destroy
  has_many :users_ledger, through: :users, source: :ledgers
  # belongs_to :admin_user, :class_name => 'AdminUser'
  has_many :resellers, :class_name => 'AdminUser', :foreign_key => 'admin_user_id'
  has_many :sub_admins, :class_name => 'AdminUser', :foreign_key => 'sub_admin_user_id'

  scope :order_by_older, -> { order(created_at: :asc) }
  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :search, -> (query) { where('email ilike :search or first_name ilike :search or last_name ilike :search', search: "%#{query}%") }
  scope :search_by_amount, -> (type, min, max) { joins(:wallets).where(wallets: { wallet_type: type, available_amount: (min..max) }) }
  
  LABLES = {
    DEFAULT = 'default' => 0,
    SUPER_AFFILIATE = 'super_affiliate' => 1,
    MASTER_AFFILIATE = 'master_affiliate' => 2,
    AFFILIATE = 'affiliate' => 3

  }
  
  enum label: LABLES

  after_create :create_wallet
  after_create :generate_agent_code

  def admin_user
    AdminUser.find_by(id: admin_user_id || sub_admin_user_id)
  end

  def available_amount
    # currency_wallet.available_amount
    point_wallet.available_amount
  end

  def self_amount
    reseller_wallet.available_amount
  end

  def is_reseller?
    has_role? :reseller
  end

  def is_super_admin?
    has_role? :super_admin
  end

  def is_sub_admin?
    has_role? :sub_admin
  end

  def active_for_authentication?
    super && is_user_enable?
  end

  def is_user_enable?
    enable
  end

  def inactive_message
    is_user_enable? ? super : I18n.t('devise.failure.inactive')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def active_for_authentication?
    super && !discarded?
  end
  
  def valid_creation
    #errors.add(:base, 'Unauthorized action') if admin_user&.individual?
  end

  def reseller_stats(start_date, end_date)
    {
      wagered_amount: Bet.between(start_date, end_date).valid_bets_by_admin(id).sum(:stake),
      won_amount: Bet.won.between(start_date, end_date).valid_bets_by_admin(id).sum(:winnings),
      lost_amount: Bet.lost.between(start_date, end_date).valid_bets_by_admin(id).sum(:stake)
    }
  end

  def affiliate_stats
    {
     wagered_amount: User.users_wagered_amount(users.ids)
    }
  end

  def custom_commision?
    commision&.dig(:enabled).eql? "true"
  end

  private

  def create_wallet
    # wallets.create(wallet_type: :currency, is_current: true, currency: Constants::DEFAULT_CURRENCY)
    wallets.create(wallet_type: :point)
    wallets.create(wallet_type: :reseller)
  end

  def generate_agent_code
    return if code.present?

    update_columns(code: "AF-#{format('%.6d', id)}#{Time.current.strftime('%y%U%u')}")
  end
end
