class User::UpdateLimitsIntr < ApplicationInteraction
  include Utility::UserLimitsHelper

  object :user
  string :reality_check_limit, default: nil
  string :timeout_limit, default: nil
  string :zone_name, default: nil
  string :current_password
  string :max_one_bet_amount, default: nil
  string :max_daily_bet_amount, default: nil
  string :max_weekly_bet_amount, default: nil
  string :max_monthly_bet_amount, default: nil
  string :max_single_amount, default: nil
  string :max_day_deposit_amount, default: nil
  string :max_weekly_deposit_amount, default: nil
  string :max_monthly_deposit_amount, default: nil
  string :limit_selector, default: 'default'
  
  validate :validate_timeout_limit
  validate :validate_limits

  def execute
    return if user.update_with_password(limit_params)
    errors.merge!(user.errors)
  end

  def limit_params
    filtered_inputs.merge(time_limit_params)
                   .compact
                   .inject({}) { |h, (k, v)| h[k] = v.eql?(-1) ? nil : v; h }
  end

  def filtered_inputs
    inputs.except(:reality_check_limit, :timeout_limit, :user, :limit_selector)
  end

  def time_limit_params
    { exclusion_time: exclusion_time, reality_check_timer: reality_check_timer }
  end

  def exclusion_time
    return if timeout_limit.nil? || zone_name.nil?
    return -1 if timeout_limit.blank?
    new_limit = time_limit(timeout_limit)
    (Time.zone.now + new_limit).in_time_zone(zone_name).utc
  end

  def reality_check_timer
    return if reality_check_limit.nil?
    return -1 if reality_check_limit.blank?
    new_limit = time_limit(reality_check_limit)
    Time.zone.strptime(new_limit&.to_s, '%s')
  end
 
  def validate_timeout_limit
    return if timeout_limit.blank? #|| zone_name.blank?
    return if Constants::TIME_OUT_LIMIT.include?(timeout_limit)
    errors.add(:timeout_limit, I18n.t(:invalid_time_period))
  end

  def time_limit(limit)
    return 10.year if timeout_limit && timeout_limit == 'Indefinite'

    time_string, unit = limit&.split
    time_string&.to_i&.send(unit&.downcase)
  end
end
