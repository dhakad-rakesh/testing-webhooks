module Admin::CustomHelper
  def sport_options
    Sport.pluck(:name, :id).insert(0, ['All', 'all'])
  end

  def match_status_options
    # Match.pluck(:status).uniq.insert(0, ['All'])
    # Match.pluck(:status).sort.uniq.map {|k| [k.humanize, k] }
    [
      ["Abandoned", "abandoned"],
      ["About to start", "about_to_start"],
      ["Cancelled", "cancelled"],
      ["Ended", "ended"],
      ["In progress", "in_progress"],
      ["Interrupted", "interrupted"],
      ["Live", "live"],
      ["Not started", "not_started"]
    ]
  end

  def bet_status_options
    Bet.statuses.keys.map { |status| [status.humanize, status] }
  end

  def highlighted_options
    [['All', 'all'], ['Highlighted', 'true'], ['Unhighlighted', 'false']]
  end

  def enabled_options
    [['All', 'all'], ['Enabled', 'true'], ['Disabled', 'false']]
  end

  def enable_options
    [['Enabled', 'true'], ['Disabled', 'false']]
  end

  def tournament_options
    Tournament.order(:rank).pluck(:name, :id)
  end

  def market_categories_options
    Category.market
            .order(:name)
            .pluck(:name, :id)
            .map { |name, id| [name.humanize, id] unless name.eql?('all') }
            .compact
  end

  def sports_options
    Sport.visible.group_by(&:kind).map { |cat, obj| [cat.humanize, obj.map { |o| [o.name, o.id] }] }
  end

  def countries_options
    Country.order(:name).pluck(:name, :id)
  end

  def countries_name_options
    Country.order(:name).pluck(:name)
  end

  def options_for_currency
    options_for_select(Wallet.currencies.keys)
  end

  def country_with_code_options
    ISO3166::Country.all.map { |c| ["#{c.alpha3} (+#{c.country_code})", c.country_code] }
  end

  def true_false_options
    %w[true false].map { |k| [k.humanize, k] }
  end

  def yes_no_options
    [['Yes', true], ['No', false]]
  end

  def parse_phone_number(phone)
    return [nil, nil] unless phone.present?
    return [params[:country_code], params[:phone_number]] if params[:country_code].present? && params[:phone_number].present?

    parsed_phone = Phonelib.parse(phone)
    country_code = parsed_phone.country_code
    phone = parsed_phone.e164.remove("+#{country_code}")
    [country_code, phone]
  end

  def country_filter_options
    options_for_select(ISO3166::Country.all_translated)
  end

  def email_filter_options
    data = [
      ['Verified', :verified],
      ['Verification Pending', :verification_pending],
    ]
    options_for_select(data, 'All')
  end

  def sport_kind_options
    Sport::KINDS.map {|k,v| [k.to_s.humanize, v]}
  end
  
  # def parse_phone_number(phone)
  #   return [nil, nil] unless phone.present?

  #   parsed_phone = Phonelib.parse(phone)
  #   country_code = parsed_phone.country_code
  #   phone = parsed_phone.e164.remove("+#{country_code}")
  #   [country_code, phone]
  # end
  
  def payment_operations_options
    options_for_select([['Withdraw', 'withdrawals'], ['Deposit', 'deposits']])
  end

  def format_currency(amount:, currency: Constants::CURRENCIES[:eth])
    # unit = currency[:unit]
    # format = currency[:format]
    # number_to_currency(amount, precision: 6, unit: unit, format: format)
    "<div class='currency-icon'><span>#{number_with_precision(amount, precision: 6)}#{image_tag('eth-icon')}</span></div>".html_safe
  end

  def short_date(date, zone = Constants::TIME_ZONE, format = '%e %b %Y')
    date&.in_time_zone(zone)&.strftime(format)
  end

  def short_date_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M')
    date&.in_time_zone(zone)&.strftime(format)
  end
  
  def promo_status_options(selected: nil)
    options_for_select(PromoCode.statuses.keys.map {|v| [v.humanize, v]}, selected)
  end

  def promo_kind_options(selected: nil)
    options_for_select(PromoCode.kinds.keys.map {|v| [v.humanize, v]}, selected)
  end

  def promo_type_options(selected: nil)
    options_for_select(PromoCode.promo_types.keys.map {|v| [v.humanize, v]}, selected)
  end

  def payment_system_options
    Ledger.modes.keys.map { |mode| [mode.humanize, mode] }
  end

  def transaction_type_options
    ['debit', 'credit'].map { |type| [type.humanize, type]}
  end

  def transaction_status_options
    Ledger::STATUSES.keys.map { |status| [status.humanize, status] }
  end

  def play_type_options
    Bet.play_types.keys.map { |k| [k.humanize, k] }
  end

  def payment_type_options
    [['Deposit', 'deposit_transactions'],
    ['Withdrawals', 'withdrawal_transactions'],
    ['Betting', 'betting_transactions'],
    ['Referrals',  'referral_transactions'],
    ['Cashbacks', 'cashback_transactions']]
  end

  def matches_options
    options_for_select(Match.pluck(:name, :id))
  end

  def label_options(admin_label:)
    admin_label_rank = AdminUser::LABLES[admin_label]
    AdminUser::LABLES.select { |_, label_rank| label_rank > admin_label_rank }.map { |k, _| [k.humanize, k] }
  end

  def reseller_options
    AdminUser.where.not(admin_user_id: nil)
             .map { |u| ["#{u.id} | #{u.full_name.humanize}", u.id] }
             .insert(0, ['Self', nil])
  end

  def resellers_option
    current_admin_user&.resellers
                        .map { |r| [r&.full_name&.humanize, r.id] }
                        .insert(0, ['All', nil])
  end

  def settings_page_path
    setting = GammabetSetting.find_or_initialize_by(setting_of: :application)
    edit_admin_gammabet_setting_path(setting)
  end

  def popup_screen_options
    Popup.screens.keys.map { |k| [k.humanize, k] }
  end

  def popup_platform_options
    Popup.platforms.keys.map { |k| [k.humanize, k] }
  end

  def popup_status_options
    Popup.statuses.keys.map { |k| [k.humanize, k] }
  end

  def popup_repeat_type_options
    Popup.repeat_types.keys.map { |k| [k.humanize, k] }
  end

  def transaction_type(value)
    Ledger::TRANSACTION_TYPES.select {|k,v| v == value.to_i}
                             .keys
                             .first
                             .humanize
  end

  def transaction_type_enumerated_options
    Ledger::TRANSACTION_TYPES.map {|k,v| [k.humanize, v]}
  end

  def game_options
    CasinoItem.pluck(:name, :id)
  end

  def slot_game_options
    SlotGame.pluck(:name, :id)
  end

  def bet_type_options
    SessionTransaction::BET_TYPES.map {|type| [type.humanize, type]}
  end
end
