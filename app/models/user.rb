class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  include Extensions::User::WalletManagement
  include Extensions::User::Mail
  include Extensions::User::FriendShip
  include Extensions::User::Favourite
  include Extensions::User::Associations
  include Extensions::User::Authentication
  include UserStateMachine
  include Trimmer
  include Discard::Model
  include Utility::UserLimitsHelper
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  
  attr_accessor :user_created_by_admin
  attr_accessor :rank, :disable_rc_timer
  attr_accessor :limit_selector
  #delegate :available_amount, to: :point_wallet

  store :settings, coder: Hash, accessors: %I[
    street house_number town_city zip_code
    favourite_tournaments favourite_sports favourite_teams gender language dialect country
    occupation organization odds_format chapter_name
    chapter_name chapter_country chapter_city chapter_zip chapter_street
    interest_online_talk interest_online_video_talk interest_online_video_competition
    favourite_team favourite_league favourite_tournament favourite_cup kyc_status_notes
    disabled_sports max_one_bet_amount max_daily_bet_amount max_weekly_bet_amount max_monthly_bet_amount
    max_single_amount max_day_deposit_amount max_weekly_deposit_amount max_monthly_deposit_amount
    bank_name account_number account_holder_name two_factor_authentication
    balance_amount_limit locale notification_key device_ids max_single_casino_stake max_daily_casino_stake
    max_weekly_casino_stake max_monthly_casino_stake
  ]
  # TODO: Add bank details to schema & validations 

  after_initialize :initialize_user_settings_defaults, if: :new_record?

  trimmed_fields :first_name, :last_name, :email, :username, :phone_number
  has_one_attached :selfie_picture
  has_one_attached :govt_id_picture
  has_one_attached :id_picture
  has_many :wallets, as: :usable, dependent: :destroy
  has_many :ledgers, as: :betable, dependent: :destroy, through: :wallets
  has_many :user_transactions

  enum user_type: { normal: 0, metamask: 1 }
  enum two_factor_status: { not_done: 0, pending: 1, completed: 2 }

  # validates :phone, phone: true, presence: true, uniqueness: true
  # validates :unverified_phone, allow_blank: true, phone: true

  # validates_presence_of :first_name, :last_name
  # validates :first_name, presence: true, length: { in: 2..20 }
  # validates :last_name, presence: true, length: { in: 2..20 }

  validate :image_validation
  validate :validate_unverified_phone, if: :unverified_phone_changed?

  validate :validate_date_of_birth, if: :date_of_birth_changed?
  validate :supported_locale

  # validate :user_limits_validation, on: :update
  # validate :bet_limits, on: :update
  # validate :deposit_limits, on: :update
  validate :validate_limits, on: :update

  validate :kyc_images_validation
  before_validation :downcase_fields
  # after_validation :set_deposit_address, on: :create
  after_create :set_deposit_address
  after_create :create_associated_wallets
  # before_save :generate_address
  after_create :set_user_number_based_on_id
  after_create :generate_referral_code
  after_save :update_user_subscriptions
  before_update :assign_admin_updated_at, if: :admin_user_id_changed?

  scope :available, -> { where(enabled: true) }
  scope :todays, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) } 
  scope :online, lambda { where("last_activity_at > ?", 10.minutes.ago) }
  scope :search, -> (query) { where("username ilike :search", search: "%#{query}%")}
  # scope :search, -> (query) { where("email ilike :search or username ilike :search or (first_name || ' ' || last_name) ilike :name", search: "%#{query}%", name: "%#{query.split().join('% ')}%")}
  scope :search_by_amount, -> (min, max) { joins(:wallets).where(wallets: { wallet_type: 'point', available_amount: (min..max) }) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }
  scope :signed_in_between, -> (start_date, end_date) { where(last_sign_in_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }
  scope :by_users, ->(ids) { where(id: ids) }
  scope :search_by_email, -> (email) { where(" email = ? OR unconfirmed_email = ? ", email.downcase, email.downcase) }
  scope :email_confirmed_users, -> { where("email IS NOT NULL AND email != ? ", "") }
  scope :email_unconfirmed_users, -> { where("email IS NULL OR email = ? ", "") }
  scope :active_users, -> (time){ where('last_activity_at >= ?', time) }
  scope :inactive_users, -> (time){ where('last_activity_at < ?', time) }
  scope :users_wagered_amount, ->(ids) { by_users(ids).joins(:wallets).where(wallets: { wallet_type: 'point'}).sum(:wagered_amount) }

  accepts_nested_attributes_for :address, update_only: true
  accepts_nested_attributes_for :admin_user, update_only: true
  accepts_nested_attributes_for :referrer_relation

  ONBOARDING_INTERACTION_MAP = {
    'complete_profile' => Onboarding::CompleteProfileIntr,
    'update_contact_details' => Onboarding::UpdateContactDetailsIntr,
    'complete_phone_verification' => Onboarding::CompletePhoneVerificationIntr
  }

  delegate :street_address,
           :zip_code,
           :country,
           :state,
           :city,
           to: :address, allow_nil: true, prefix: true

  def email_required?
    false
  end

  def first_login?
    !last_sign_in_at?
  end

  def password_required?
    return false if new_record?
    super
  end

  def unverified_phone=(phone_number)
    normalized_phone = phone_number&.gsub(/\D/, '')
    return if phone_number == phone
    write_attribute(:unverified_phone, normalized_phone)
  end

  def phone=(phone_number)
    normalized_phone = phone_number&.gsub(/\D/, '')
    write_attribute(:phone, normalized_phone)
  end

  def document_uploaded?
    selfie_picture.attached? && govt_id_picture.attached? && id_picture.attached?
  end

  def validate_unverified_phone
    return unless unverified_phone
    # validate_phone_country(unverified_phone)
    validate_phone_availability(unverified_phone)
  end

  def validate_phone_country(phone_number)
    return if phone_number.blank? || parsed_phone(phone_number).valid_for_country?(country_alpha_2)
    errors.add(:phone, 'is not valid for country')
  end

  def validate_date_of_birth
    return if date_of_birth.blank?
    errors.add(:age, "must be greater than 18.") if Date.today < (date_of_birth + 18.years)
    errors.add(:age, "must be 100 or below.") if Date.today >= (date_of_birth + 100.years)
  end

  def validate_phone_availability(phone_number)
    user = User.where(phone: phone_number).first
    return unless user
    errors.add(:phone, :not_available)
  end

  def parsed_phone(phone_number = phone)
    Phonelib.parse(phone_number)
  end

  def generate_address
    return unless phone_changed?
    build_address(country: phone_country&.name)
  end

  def phone_country
    Address.country_for_code(parsed_phone.country_code) 
  end
  
  def country_code
    address&.country_details&.country_code
  end

  def country_alpha_2
    address&.country_details&.alpha2
  end

  def betting_allowed?
    is_betting_allowed
  end

  def withdraw_allowed?(amount)
    current_wallet.withdrawable_amount >= amount.to_f
  end

  def bet_limits_present?
    max_one_bet_amount.present? &&
      max_daily_bet_amount.present? &&
      max_weekly_bet_amount.present? &&
      max_monthly_bet_amount.present?
  end

  def deposit_limits_present?
    max_single_amount.present? &&
      max_day_deposit_amount.present? &&
      max_weekly_deposit_amount.present? &&
      max_monthly_deposit_amount.present?
  end

  def image_validation
    return unless image.attached?
    blob_object = image.blob
    validation_message =
      if blob_object.byte_size > 8_000_000
        image.purge
        I18n.t('big_image')
      elsif !blob_object.content_type.starts_with?('image/')
        image.purge
        I18n.t('wrong_img_format')
      end
    errors[:base] << validation_message if validation_message
  end

  # def kyc_images_validation
  #   %w[selfie_picture govt_id_picture].each do |img|
  #     next unless send(img).attached?
  #     blob_object = send(img).blob

  #     unless blob_object.content_type.starts_with?('image/')
  #       send(img).purge
  #       errors[:base] << I18n.t('wrong_img_format')
  #     end
  #   end
  # end

  def kyc_images_validation
    return unless document_uploaded?
    %w[selfie_picture govt_id_picture id_picture].each do |file|
      file = send(file)
      return errors[:base] << I18n.t('wrong_img_format') unless ( file.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/ ) || ( file.content_type.in?(["application/pdf"]) )
    end
  end

  def downcase_fields
    self.username&.downcase!
  end

  def self.list(search)
    return all if search == 'all'
    where('first_name LIKE ?', "%#{search}%")
  end

  def self.from_omniauth(auth)
    return :invalid_email if auth.info.email.blank?
    where(email: auth.info.email).first_or_create do |user|
      user.assign_attributes(email: auth.info.email, password: Devise.friendly_token[0, 20] + 'Aa@2',
                             first_name: auth.info.first_name, last_name: auth.info.last_name,
                             username: SecureRandom.hex(10))
      user.skip_confirmation!
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).find_by(['username = :value OR email = :value', { value: login }])
    elsif conditions.key?(:username) || conditions.key?(:email)
      find_by(conditions.to_h)
    end
  end

  def points_info(type)
    bets = self.bets.where(bet_type: type)
    points_won = bets.won.inject(0) { |_sum, bet| (bet.odds.to_f - 1) * bet.stake }
    {
      points_put_in: bets.sum(:stake),
      points_lost: bets.lost.sum(:stake),
      points_won: points_won,
      bet_count: bets.count
    }
  end

  def after_confirmation
    WelcomeMailer.sender(email).deliver_later
  end

  def reassociate_topics(topics)
    return if topics.blank?
    self.topics.destroy_all
    topics.each do |topic|
      Topic.find_or_create_topic(topic[:name].downcase).users << self
    end
  end

  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml
    super && user_not_in_exclusion_time? && is_user_enabled?
  end

  def inactive_message
    local_exclusion_time = exclusion_time&.in_time_zone&.strftime("%d/%m/%Y %I:%M:%S %p %Z")
    user_not_in_exclusion_time? ? super : I18n.t('devise.failure.exclusion_period', time: local_exclusion_time )
  end
  
  def user_not_in_exclusion_time?
    return true if exclusion_time.nil?
    Time.zone.now >= exclusion_time
  end

  def is_user_enabled?
    enabled
  end

  def kyc_status
    super || 'NotDone'
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def available_amount
    current_wallet&.available_amount
  end

  def et2_amount
    available_amount * 1000
  end

  def bonus_amount
    current_wallet&.bonus
  end

  def placed_bets
    bets.where(bet_type: :traditional).order(created_at: :desc).limit(Constants::MAX_BET_SHOW_COUNT)
  end

  def total_bets
    bets.not_combo.count + combo_bets.count + session_transactions.bet_types.count
  end

  def frequent_payees
    payees.uniq
  end

  def total_betted_winning
    combo_betted_winning + signle_betted_winning
  end

  def combo_betted_winning
    combo_bets.today_combo_bets.sum('CAST(odds as decimal)*stake') rescue 0
  end

  def signle_betted_winning
    bets.not_combo.today_bets.sum('CAST(odds as decimal)*stake') rescue 0
  end

  def set_user_number_based_on_id
    return if user_number.present?
    update_columns(user_number: "KB-#{format('%.6d', id)}#{Time.current.strftime('%y%U%u')}")
  end

  def show_real_time_user_wallet
    ActionCable.server.broadcast(
      'user_balance_channel',
      {
        user_id: id,
        balance: available_amount.round(8),
        bonus: bonus_amount.round(8)
      }
    )
  end

  # TODO: Typed user settings
  def initialize_user_settings_defaults
    self.disabled_sports = []
    self.locale = 'en'
    self.device_ids = []
  end

  def supported_locale
    return if locale.blank? || I18n.available_locales.include?(locale.to_sym)
    errors.add(:locale, :not_supported)
  end
  
  # def user_limits_validation
  #   errors.add(:limits, "must be positive") if limit_negative?
  # end

  # def bet_limits
  #   errors.add(:base, "Monthly limit should be greater than weekly limit") if(max_monthly_bet_amount.to_f < max_weekly_bet_amount.to_f)
  #   errors.add(:base, "Weekly limit should be greater than daily limit") if(max_weekly_bet_amount.to_f < max_daily_bet_amount.to_f)
  #   errors.add(:base, "Daily limit should be greater than single bet limit") if(max_daily_bet_amount.to_f < max_one_bet_amount.to_f)
  # end

  # def deposit_limits
  #   errors.add(:base, "Monthly limit should be greater than weekly limit") if(max_monthly_deposit_amount.to_f < max_weekly_deposit_amount.to_f)
  #   errors.add(:base, "Weekly limit should be greater than daily limit") if(max_weekly_deposit_amount.to_f < max_day_deposit_amount.to_f)
  #   errors.add(:base, "Daily limit should be greater than single deposit limit") if(max_day_deposit_amount.to_f < max_single_amount.to_f)
  # end

  # def limit_negative?
  #   max_one_bet_amount.to_f.negative? ||
  #   max_daily_bet_amount.to_f.negative? ||
  #   max_weekly_bet_amount.to_f.negative? ||
  #   max_monthly_bet_amount.to_f.negative? ||
  #   max_single_amount.to_f.negative? ||
  #   max_day_deposit_amount.to_f.negative? ||
  #   max_weekly_deposit_amount.to_f.negative? ||
  #   max_monthly_deposit_amount.to_f.negative? ||
  #   balance_amount_limit.to_f.negative?
  # end

  def monthly_stake
    bets.not_combo.monthly_stake + combo_bets.monthly_stake
  end

  def weekly_stake
    bets.not_combo.weekly_stake + combo_bets.weekly_stake
  end

  def daily_stake
    bets.not_combo.daily_stake + combo_bets.daily_stake
  end

  def monthly_casino_stake
    SessionTransaction.casino.stake_by_user(self).between(Time.zone.now.beginning_of_month, Time.zone.now).sum(:amount)
  end

  def weekly_casino_stake
    SessionTransaction.casino.stake_by_user(self).between(Time.zone.now.beginning_of_week, Time.zone.now).sum(:amount)
  end

  def daily_casino_stake
    SessionTransaction.casino.stake_by_user(self).between(Time.zone.now.beginning_of_day, Time.zone.now).sum(:amount)
  end

  def monthly_deposit
    ledgers.monthly_deposit
  end

  def weekly_deposit
    ledgers.weekly_deposit
  end

  def daily_deposit
    ledgers.daily_deposit
  end

  def deposits
    ledgers.credit.where(betable_type: 'User')
  end

  def total_balance
    (available_amount + bonus_amount).round(8)
  end

  def total_deposit
    deposits.pluck(:amount).sum
  end

  def user_settings
    { username_status: username.present?, email_status: email.present?, two_factor_status: two_factor_authentication.present?, 
      two_factor_key: two_factor_authentication, deposit_address: deposit_address, common_deposit_address: Figaro.env.COMMON_DEPOSIT_ADDRESS,
      kyc_status: kyc_status, kyc_status_notes: kyc_status_notes,
      deposit_count: deposit_count, user_type: user_type,
      selfie_picture: selfie_picture_url, govt_id_picture: govt_id_picture_url, id_picture: id_picture_url,
      metamask_address: metamask_address, balance: point_wallet.available_amount, bonus: point_wallet.betting_bonus.to_f,
      withdrawable_balance: point_wallet.withdrawable_amount, minimum_withdrawal_amount: GammabetSetting.minimum_withdrawal_amount,
      maximum_withdrawal_amount: GammabetSetting.maximum_withdrawal_amount,
      confirmed_email: email,
      unconfirmed_email: unconfirmed_email,
      upcoming_event_notification: upcoming_event_notification,
      promotional_notification: promotional_notification, referral_enabled: GammabetSetting.referral_bonus_allowed?, referral_code: referral_code,
      referral_threshold_amount: GammabetSetting.referral_threshold_amount.to_f , referral_reward_amount: GammabetSetting.referral_reward_amount.to_f
    }
  end

  def assign_admin_updated_at
    self.assign_attributes(admin_updated_at: Time.zone.now)
  end

  def generate_referral_code
    return if referral_code.present?
    update_columns(referral_code: "RF-#{format('%.6d', id)}#{Time.current.strftime('%y%U%u')}")
  end

  def amount_credited_to_referrer?
    referrer_relation&.credited?
  end

  def eligible_to_credit_referrer?
    return if referrer_relation.blank? || amount_credited_to_referrer?
    deposited_amount = ledgers.where(betable_type: 'User', transaction_type: 'credit').sum(:amount).to_f
    deposited_amount >= referrer_relation.threshold_amount
  end

  # TODO: Use something better
  def current_limits
    Constants::USER_LIMIT_ATTRIBUTES.map do |limit|
      { limit => self.send(limit) }
    end.inject(:merge).merge(time_limits)
  end

  def time_limits
    { 
      timeout_limit: exclusion_time.to_s, 
      reality_check_limit: reality_check_timer&.strftime('%M minute'),
      deposit_limit_updated_at: deposit_limit_updated_at&.in_time_zone(Constants::TIME_ZONE)&.strftime('%e %b, %H:%M'),
      bet_limit_updated_at: bet_limit_updated_at&.in_time_zone(Constants::TIME_ZONE)&.strftime('%e %b, %H:%M')
    }
  end

  def update_user_subscriptions
    return unless saved_changes[:subscribed_to_notifications].present?
    Users::ManageNotificationSubscriptionsJob.perform_later(self.id, unsubscribe: !subscribed_to_notifications)
  end

  def country_id
    Country.find_by(name: address.country)&.id
  end

  def selfie_picture_url
    Rails.application.routes.url_helpers.url_for(selfie_picture) if selfie_picture_blob.present?
  end

  def govt_id_picture_url
    Rails.application.routes.url_helpers.url_for(govt_id_picture) if govt_id_picture_blob.present?
  end

  def id_picture_url
    Rails.application.routes.url_helpers.url_for(id_picture) if id_picture_blob.present?
  end

  def valid_for_deposit?(amount)
    total_amount = amount.to_f + total_deposit
    usd_amount = GammabetSetting.conversion_rate / total_deposit
    return true unless usd_amount >= 1
    if kyc_approved? && two_factor_authentication.present?
      return true
    end
  end

  def kyc_approved?
    kyc_status == 'Approved'
  end

  def kyc_rejected?
    kyc_status == 'Rejected'
  end

  def kyc_initiated?
    kyc_status == 'Processing'
  end

  def kyc_approved_or_rejected?
    kyc_approved? || kyc_rejected?
  end

  def deposit_bonus_applicable?(amount)
    deposit_count.eql?(1) && GammabetSetting.deposit_bonus_allowed? && amount >= GammabetSetting.deposit_bonus_limit
  end

  def set_deposit_address
    # return unless normal? && deposit_key.nil?
    data = SetDepositAddress.run!(user: self)
    self.deposit_address = data.dig('data','address')&.downcase
    # self.deposit_key = data['data']['privateKey']
  rescue Exception => e
    errors.add(:base, 'something went wrong')
  end
end
