class GammabetSetting < ApplicationRecord
  after_save :update_cache_betting_allowed

  store :settings, coder: Hash, accessors: %I[conversion_rate betting_allowed fund_transfer_allowed fund_transfer_commision
                                              cashout_allowed cashout_commision fund_transfer_limit live_betting_allowed
                                              api_version auto_withdrawal_limit minimum_deposit_amount
                                              minimum_withdrawal_amount registration_disabled_countries top_countries
                                              referral_reward_amount referral_threshold_amount big_win_notification_amount
                                              max_liability_amount agent_commision maximum_withdrawal_amount
                                              registration_enabled_countries max_single_casino_stake max_daily_casino_stake
                                              max_weekly_casino_stake max_monthly_casino_stake deposit_bonus_allowed
                                              deposit_bonus_amount deposit_bonus_limit referral_bonus_allowed betting_bonus_allowed]
  enum setting_of: { application: 0 }

  validates :user_wallet_limit, :reseller_withdrawal_limit,
            :max_one_bet_amount, :max_daily_bet_amount, :max_weekly_bet_amount,
            :max_monthly_bet_amount, :max_single_amount, :max_day_deposit_amount,
            :max_weekly_deposit_amount, :max_monthly_deposit_amount, :balance_amount_limit,
            :max_single_casino_stake, :max_daily_casino_stake, :max_weekly_casino_stake,
            :max_monthly_casino_stake,
            numericality: { greater_than_or_equal_to: 0.0 }, allow_nil: true
  validate :valid_commision_percentage, on: :update
  validate :valid_cashout_commision_percentage, on: :update
  validate :valid_version_is_in_positive_numbers, on: :update
  validate :auto_withdrawal_limit_valid?
  validate :bet_limits, if: :bet_limit_changed?
  validate :deposit_limits, if: :deposits_limit_changed?
  # validate :casino_limits, if: :casino_limit_changed?
  validate :referral_amount

  def referral_amount
    return if referral_threshold_amount.blank? && referral_reward_amount.blank?

    errors.add(:referral_reward_amount, "can't be negative") if referral_reward_amount.to_f.negative?
    errors.add(:referral_threshold_amount, "can't be negative") if referral_threshold_amount.to_f.negative?
  end

  def bet_limits
    errors.add(:base, 'Monthly limit should be greater than weekly limit') if max_monthly_bet_amount.to_f < max_weekly_bet_amount.to_f
    errors.add(:base, 'Weekly limit should be greater than daily limit') if max_weekly_bet_amount.to_f < max_daily_bet_amount.to_f
    errors.add(:base, 'Daily limit should be greater than single bet limit') if max_daily_bet_amount.to_f < max_one_bet_amount.to_f
  end

  def deposit_limits
    errors.add(:base, 'Monthly limit should be greater than weekly limit') if max_monthly_deposit_amount.to_f < max_weekly_deposit_amount.to_f
    errors.add(:base, 'Weekly limit should be greater than daily limit') if max_weekly_deposit_amount.to_f < max_day_deposit_amount.to_f
    errors.add(:base, 'Daily limit should be greater than single deposit limit') if max_day_deposit_amount.to_f < max_single_amount.to_f
  end

  def casino_limits
    errors.add(:base, 'Monthly limit should be greater than weekly limit') if max_monthly_casino_stake.to_f < max_weekly_casino_stake.to_f
    errors.add(:base, 'Weekly limit should be greater than daily limit') if max_weekly_casino_stake.to_f < max_daily_casino_stake.to_f
    errors.add(:base, 'Daily limit should be greater than single limit') if max_daily_casino_stake.to_f < max_single_casino_stake.to_f
  end

  def auto_withdrawal_limit_valid?
    return if auto_withdrawal_limit.blank?

    errors.add(:auto_withdrawal_limit, "can't be negative") if auto_withdrawal_limit.to_f.negative?
  end

  def valid_commision_percentage
    return if fund_transfer_commision.blank?

    errors.add(:fund_transfer_commision, 'must be between 0-100') unless fund_transfer_commision.to_f.in?(0..100)
    errors.add(:fund_transfer_commision, 'must be present') if fund_transfer_commision.blank?
  end

  def valid_cashout_commision_percentage
    return if cashout_commision.blank?

    errors.add(:cashout_commision, 'must be between 0-100') unless cashout_commision.to_f.in?(0..100)
    errors.add(:cashout_commision, 'must be present') if cashout_commision.blank?
  end

  def valid_version_is_in_positive_numbers
    return if api_version.blank?

    errors.add(:api_version, 'must be a positive number') unless api_version.to_f > 0.to_f
  end

  def self.betting_allowed?
    first.allow_betting
  end

  def self.allow_betting
    first.update_attribute(:allow_betting, true)
  end

  def self.suspend_betting
    first.update_attribute(:allow_betting, false)
  end

  def self.fund_transfer_allowed?
    first.fund_transfer_allowed === '1'
  end

  def self.allow_fund_transfer
    first.update_attribute(:fund_transfer_allowed, 1)
  end

  def self.suspend_fund_transfer
    first.update_attribute(:fund_transfer_allowed, 0)
  end

  def self.fund_transfer_commision
    first.fund_transfer_commision.to_f
  end

  def self.fund_transfer_limit
    first.fund_transfer_limit.to_f
  end

  def self.cashout_allowed?
    first.cashout_allowed === '1'
  end

  def self.deposit_bonus_allowed?
    first.deposit_bonus_allowed === '1'
  end
  
  def self.referral_bonus_allowed?
    first.referral_bonus_allowed === '1' rescue false
  end

  def self.cashout_commision
    first.cashout_commision.to_f || 0
  end

  def self.deposit_bonus_amount
    first.deposit_bonus_amount.to_f || 0
  end

  def self.deposit_bonus_limit
    first.deposit_bonus_limit.to_f || 0
  end

  def self.live_betting_allowed?
    first.live_betting_allowed
  end

  def self.allow_live_betting
    first.update_attribute(:live_betting_allowed, true)
  end

  def self.suspend_live_betting
    first.update_attribute(:live_betting_allowed, false)
  end

  def self.apk_version
    first.api_version
  end

  def self.user_wallet_limit
    first.user_wallet_limit
  end

  def self.reseller_withdrawal_limit
    first.reseller_withdrawal_limit
  end

  def self.auto_withdrawal_limit
    first.auto_withdrawal_limit.to_f || Constants::MAX_AUTO_WITHDRAWAL_LIMIT
  end

  def self.minimum_deposit_amount
    first.minimum_deposit_amount&.to_f || 0
  end

  def self.minimum_withdrawal_amount
    first.minimum_withdrawal_amount&.to_f || 0
  end

  def self.maximum_withdrawal_amount
    first.maximum_withdrawal_amount&.to_f || Constants::MAX_WITHDRAWAL_LIMIT
  end

  def self.registration_disabled_countries
    first.registration_disabled_countries || []
  end

  def self.registration_enabled_countries
    first.registration_enabled_countries || []
  end

  def self.top_countries
    first.top_countries || []
  end

  def deposits_limit_changed?
    max_monthly_deposit_amount_changed? ||
      max_weekly_deposit_amount_changed? ||
      max_day_deposit_amount_changed? ||
      max_one_bet_amount_changed?
  end

  def bet_limit_changed?
    max_monthly_bet_amount_changed? ||
      max_weekly_bet_amount_changed? ||
      max_daily_bet_amount_changed? ||
      max_one_bet_amount_changed?
  end

  def casino_limit_changed?
    max_monthly_casino_stake_changed? ||
      max_weekly_casino_stake_changed? ||
      max_daily_casino_stake_changed? ||
      max_single_casino_stake_changed?
  end

  def self.max_monthly_deposit_amount
    first.max_monthly_deposit_amount&.to_f || Constants::MAX_MONTHLY_DEPOSIT_LIMIT
  end

  def self.max_weekly_deposit_amount
    first.max_weekly_deposit_amount&.to_f || Constants::MAX_WEEKLY_DEPOSIT_LIMIT
  end

  def self.max_day_deposit_amount
    first.max_day_deposit_amount&.to_f || Constants::MAX_DAY_DEPOSIT_LIMIT
  end

  def self.max_single_amount
    first.max_single_amount&.to_f || Constants::MAX_SINGLE_LIMIT
  end

  def self.max_monthly_bet_amount
    first.max_monthly_bet_amount&.to_f || Constants::MAX_MONTHLY_BET_LIMIT
  end

  def self.max_weekly_bet_amount
    first.max_weekly_bet_amount&.to_f || Constants::MAX_WEEKLY_BET_LIMIT
  end

  def self.max_daily_bet_amount
    first.max_daily_bet_amount&.to_f || Constants::MAX_DAILY_BET_LIMIT
  end

  def self.max_one_bet_amount
    first.max_one_bet_amount&.to_f || Constants::MAX_ONE_BET_LIMIT
  end

  def self.balance_amount_limit
    first.balance_amount_limit&.to_f || Constants::MAX_BALANCE_LIMIT
  end

  def self.referral_reward_amount
    first.referral_reward_amount || {}
  end

  def self.referral_threshold_amount
    first.referral_threshold_amount || {}
  end

  def self.big_win_notification_amount
    first.big_win_notification_amount || {}
  end

  def self.max_liability_amount
    first.max_liability_amount&.to_f || Constants::MAX_LIABILITY_AMOUNT
  end

  def self.conversion_rate
    first.conversion_rate.to_f
  end

  def self.betting_bonus_allowed?
    first.betting_bonus_allowed.eql?("1") rescue false
  end

  private

  def update_cache_betting_allowed
    Rails.cache.delete(:betting_allowed)
    Rails.cache.fetch(:betting_allowed) do
      allow_betting
    end
  end
end
