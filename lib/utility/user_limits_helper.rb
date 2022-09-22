module Utility
  module UserLimitsHelper
    attr_accessor :err
    
    LIMIT_ATTRIBUTES = {
      bet: %w[max_monthly_bet_amount max_weekly_bet_amount max_daily_bet_amount max_one_bet_amount],
      deposit: %w[max_monthly_deposit_amount max_weekly_deposit_amount max_day_deposit_amount max_single_amount],
      balance: %w[balance_amount_limit],
      casino: %w[max_single_casino_stake max_daily_casino_stake max_weekly_casino_stake max_monthly_casino_stake]
    }
    
    def validate_limits
      return if LIMIT_ATTRIBUTES.keys.exclude?(limit_selector&.to_sym) || blank_limits?
      valid_limits?
    end
    
    def blank_limits?
      attributes_arr.blank?
    end
    
    def valid_limits?
      @err = []
      validate_limits_within
      validate_limits_globally
      errors.add(:base, err.first) unless err.blank?
    end
    
    def validate_limits_within
      attributes_arr.each_with_index do |current_attr, i|
        attributes_arr[i+1..attributes_arr.length].each do |comparator|
          err << I18n.t(:should_be_greater_eq, current: I18n.t(current_attr.to_sym), comparator: I18n.t(comparator.to_sym)) if eval(current_attr).to_f < eval(comparator).to_f
        end
      end
    end
    
    def validate_limits_globally
      attributes_arr.each do |attribute|
        err << I18n.t(:cant_exceed_global, attribute: I18n.t(current_attr.to_sym)) if GammabetSetting.send(attribute) < eval(attribute).to_f
      end
    end
    
    def attributes_arr
      LIMIT_ATTRIBUTES[limit_selector.to_sym].select { |attribute| eval(attribute).present? && eval(attribute).to_f != -1 }
    end

    def valid_bet_limits(user:, stake:)
      return errors.add(:stake, I18n.t(:single_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_one_bet_amount) < stake
      return errors.add(:stake, I18n.t(:daily_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_daily_bet_amount) < (user.daily_stake + stake)
      return errors.add(:stake, I18n.t(:weekly_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_weekly_bet_amount) < (user.weekly_stake + stake)
      return errors.add(:stake, I18n.t(:monthly_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_monthly_bet_amount) < (user.monthly_stake + stake)
    end

    def valid_deposit_limits(user:, amount:)
      deposit_error(err_msg: I18n.t(:max_amount_limit_exceeded)) if user_limit(user: user, attribute: :balance_amount_limit) < (amount + user.current_wallet.available_amount)
      deposit_error(err_msg: I18n.t(:single_deposit_limit_exceeded)) if user_limit(user: user, attribute: :max_single_amount) < amount
      deposit_error(err_msg: I18n.t(:daily_deposit_limit_exceeded)) if user_limit(user: user, attribute: :max_day_deposit_amount) < (user.daily_deposit + amount)
      deposit_error(err_msg: I18n.t(:weekly_deposit_limit_exceeded)) if user_limit(user: user, attribute: :max_weekly_deposit_amount) < (user.weekly_deposit + amount)
      deposit_error(err_msg: I18n.t(:monthly_deposit_limit_exceeded)) if user_limit(user: user, attribute: :max_monthly_deposit_amount) < (user.monthly_deposit + amount)
    end

    def validate_casino_limit(user:, stake:)
      bet_limit_error(err_msg: I18n.t(:single_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_single_casino_stake) < stake
      bet_limit_error(err_msg: I18n.t(:daily_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_daily_casino_stake) < (user.daily_casino_stake + stake)
      bet_limit_error(err_msg: I18n.t(:weekly_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_weekly_casino_stake) < (user.weekly_casino_stake + stake)
      bet_limit_error(err_msg: I18n.t(:monthly_bet_limit_exceeded)) if user_limit(user: user, attribute: :max_monthly_casino_stake) < (user.monthly_casino_stake + stake)
    end

    def bet_limit_error(err_msg:)
      raise ::Casino::BetLimit, err_msg
    end

    def user_limit(user:, attribute:)
      [user, GammabetSetting].map { |source| source.send(attribute).presence&.to_f }.compact.min
    end

  end
end