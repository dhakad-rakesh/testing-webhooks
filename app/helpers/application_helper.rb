module ApplicationHelper
  def active_controller(controller_name, class_name = nil)
    return unless controller_name.include?(params[:controller])

    class_name.nil? ? 'active' : class_name
  end

  def active_action(action_name)
    params[:action] == action_name ? 'active' : nil
  end

  def active_actions(actions)
    actions.include?(params[:action]) ? 'active' : nil
  end

  def active_controller_actions(controller_name, actions)
    (active_controller(controller_name) && active_actions(actions)) ? 'active' : nil
  end

  def active_settings
    active_controller('admin/gammabet_setting') && active_action('edit_transfer_settings')
  end

  def hours_minutes_format(time)
    time&.strftime('%H:%M')
  end

  def self_exclusion_format(time)
    time&.strftime('%Y-%m-%d %H:%M %p')
  end

  def is_specifier_market?(market_uid)
    Constants::SPECIFIRE_MARKETS.include? market_uid
  end

  def is_non_specifier_market?(market_uid)
    # prematch markets are non specifier for now
    Constants::PREMATCH_MARKETS.include? market_uid
  end

  def active_inplay
    %w[matches sports].include?(params[:controller]) && %w[index show].include?(params[:action]) && session[:scope] == 'live' ? 'active' : ''
  end

  def active_today
    %w[matches sports].include?(params[:controller]) && %w[index show].include?(params[:action]) && session[:scope] == 'today' ? 'active' : ''
  end

  def active_my_bets
    %w[bets].include?(params[:controller]) && params[:action] == 'my_bets' ? 'active' : ''
  end

  def active_home
    params[:controller] == 'dashboard' && params[:action] == 'index' && !request.url.include?('sport_bettings') ? 'active' : ''
  end

  def active_soccer
    %w[matches sports].include?(params[:controller]) && %w[index show].include?(params[:action]) && session[:scope].nil? ? 'active' : ''
  end

  def active_sports
    active_soccer
  end

  def title_with_match_count(sport)
    title = sport.name.titleize
    title += " (#{sport.matches.active_matches.count})"
    title
  end

  def admin_wallet_options
    [['Admin Wallet', 'admin'], ['Self Wallet', 'reseller']]
  end

  def enabled_market?(market_uid)
    (Constants::PREMATCH_MARKETS.include? market_uid) || (Constants::INPLAY_MARKETS.include? market_uid)
  end

  def match_outcome_name(outcome, market_uid)
    outcome_name = outcome[:name].to_s
    outcome_name = '1' if outcome_name == 'Home'
    outcome_name = '2' if outcome_name == 'Away'
    outcome_name = 'X' if outcome_name == 'Draw'
    outcome_name = 'Even' if ['Home - Even', 'Away - Even'].include?(outcome_name)
    outcome_name = 'Odd' if ['Home - Odd', 'Away - Odd'].include?(outcome_name)
    outcome_name = '1st' if ['Home - 1st Half', 'Away - 1st Half'].include?(outcome_name)
    outcome_name = '2nd' if ['Home - 2nd Half', 'Away - 2nd Half'].include?(outcome_name)
    outcome_name = 'Tie' if ['Home - Tie', 'Away - Tie'].include?(outcome_name)
    # outcome_name = outcome_name.split(" ")[1] if outcome_name.match(/\w*\s[0-9]-[0-9]/)
    # unless outcome_name.match(/\w*\s-\s\d\w*/)
    #   outcome_name = outcome_name.gsub('Home', '1') if outcome_name.include?('Home')
    #   outcome_name = outcome_name.gsub('Draw', 'X') if outcome_name.include?('Draw')
    #   outcome_name = outcome_name.gsub('Away', '2') if outcome_name.include?('Away')
    # end
    return [outcome_name, outcome[:handicap].to_s].uniq.join(' ') if outcome[:handicap].present? && market_uid.to_s != Market::GOAL_SEQUENCE_MARKET_UID

    outcome_name
  end

  def bet_row_class(bet)
    return 'bet-row-lost' if bet.lost?

    bet.won? ? 'bet-row-win' : ''
  end

  def get_combo_bet_status(combo)
    return 'won' if combo.status == 'won'
    return 'lost' if combo.status == 'lost'
    return 'cashed_out' if combo.status == 'cashed_out'

    'pending'
  end

  def get_combo_bet_class(combo)
    return 'badge badge-danger' if combo.status == 'lost'
    return 'badge badge-success' if combo.status == 'won'

    'badge badge-default'
  end

  def get_bet_status(bet)
    return 'combo-bet-row-red' if bet.status == 'lost'

    'combo-bet-row-green' if bet.status == 'won'
  end

  def sport_active_class(sport)
    params[:controller].downcase == 'sport' && sport.status == 'active' ? 'active' : ''
  end

  def casino_active_class
    params[:controller].downcase == 'casino' && params[:live_casino].blank? ? 'active' : ''
  end

  def casino_lobby_active_class
    params[:controller].downcase == 'casino' && params[:live_casino] == 'true' ? 'active' : ''
  end

  def fund_transfer_active_class
    params[:controller].downcase == 'fund_transfers' && params[:transfers] == 'true' ? 'active' : ''
  end

  def url_for_apk
    GammabetSetting.first.url
  end

  def url_present_for_mobile?
    return true if mobile_device? && url_for_apk.present?

    false
  end

  def combo_odds(bet_slips)
    total_odds = bet_slips.map { |bet| bet[:odds].to_f }.inject(:*)
    NumberService.round_to_2_decimal(total_odds)
  rescue StandardError => e
    0
  end

  def get_path_for_back_button
    sport_path(id: main_sport, scope: session[:scope])
  end

  def get_odds_status(odds_changed)
    'green' if odds_changed
  end

  def highlight_search_string(text, search)
    return text if search.blank?

    _text = text.gsub(search, "<span class='highlight'>#{search}</span>")
    _text = _text.gsub(search.downcase, "<span class='highlight'>#{search.downcase}</span>") unless _text.include?('highlight')
    _text = _text.gsub(search.titleize, "<span class='highlight'>#{search.titleize}</span>") unless _text.include?('highlight')
    _text = _text.gsub(search.upcase, "<span class='highlight'>#{search.upcase}</span>") unless _text.include?('highlight')
    _text.html_safe
  end

  def current_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M %a')
    date&.in_time_zone(zone)&.strftime(format)
  end


  def precise_current_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M:%S %a')
    date&.in_time_zone(zone)&.strftime(format)
  end
  
  def short_date(date, zone = Constants::TIME_ZONE, format = '%e %b %Y')
    date&.in_time_zone(zone)&.strftime(format)
  end

  def short_date_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M')
    date&.in_time_zone(zone)&.strftime(format)
  end

  def admin_matches_search_link
    if params[:tournament_id].present?
      admin_tournament_matches_path(tournament_id: params[:tournament_id])
    else
      admin_matches_path
    end
  end

  # def current_time
  #   Time.zone.now.in_time_zone("CET").strftime("%m %b %Y, %H:%M %a")
  # end

  def schedule_time(time)
    time.in_time_zone('Moscow').strftime('%e %b %Y, %H:%M %a')
  end

  def user_type(user)
    user&.admin_user&.full_name.presence || '<b>Owner</b>'.html_safe
  end

  def liability(market, match = nil)
    if match.present?
      match.bets.pending.where(market_id: market.id).pluck(:total).sum
    else
      Rails.cache.fetch("market_#{market.uid}_liability") do
        market.bets.pending.pluck(:total).sum
      end
    end
  end

  def country_matches_count(country, sport_id)
    country.tournaments.where(sport_id: sport_id).joins(:matches).count('matches.id')
  end

  def market_count(match, ignore_ids)
    available_market = match.odds_data[:markets].select{|k,v| v['49'][:status].include?('open')}
    return 0 if available_market.blank?
    ((available_market.keys - ignore_ids) & Market.markets_enable_ids).count
  end

  def get_1x2_market(match)
    match.odds_data[:markets].each do |market_id, market_data|
      next if market_data.blank?
      return { market_id: market_id, market_data: market_data } if ['1X2'].include?(market_data.first.last[:name])
    end
  end

  def format_outcomes(outcomes, outcome_name)
    outcomes.map { |_k, v| v if v[:name] == outcome_name && v[:status] == "open" }.compact.first
  end

  def format_outcomes_handicap(outcomes, outcome_name, handicap)
    outcomes.map { |_k, v| v if v[:name] == outcome_name && v[:handicap] == handicap }.compact.first
  end

  def handicap_values(outcomes)
    outcomes.map{|o| o.last[:handicap]}.sort.uniq
  end

  def handicap_names(outcomes)
    outcomes.map{|k,v| v[:name]}.compact.uniq
  end

  def bet_settlement_amount(bet)
    return '' if %w[pending refunded hold cashed_out].include? bet.status

    amount = bet.won? ? bet.total : bet.stake
    number_with_precision(amount, precision: 2)
  end

  def even_odd(number)
    number % 2 === 0 ? 'even' : 'odd'
  end

  def get_selected_market_data(match, ui_market_id)
    match.odds_data[:markets].each do |market_id, market_data|
      next if market_data.blank?
      return { market_data: market_data } if ui_market_id == market_id
    end
  end

  def funds_transfer_allowed?
    GammabetSetting.fund_transfer_allowed?
  end

  def reselles_owner(reseller)
    reseller.admin_user&.email || '<b>Owner</b>'.html_safe
  end

  def email_or_username(user)
    return user.email if user.email.present?

    user.username
  end

  def get_match_goals_outcomes(outcomes, specifier)
    outomes_uids = []
    outcomes.each do |outcome|
      outomes_uids << outcome[:uid] unless specifier.to_s == outcome.last[:handicap].to_s
    end
    outomes_uids
  end

  def fund_transfer_commision
    NumberService.round_to_8_decimal(GammabetSetting.fund_transfer_commision)
  end

  def my_bets_page?
    params[:action] == 'my_bets'
  end

  def fund_transfer_page?
    params[:controller] == 'fund_transfers' && params[:action] == 'index'
  end

  def statement_page?
    params[:controller] == 'fund_transfers' && params[:action] == 'transaction_history'
  end

  def profile_page?
    params[:controller] == 'users' && params[:action] == 'edit'
  end

  def is_sub_admin_tab?(tab)
    tab.present? && tab == 'sub_admin'
  end

  def total_betted_winning
    current_user&.total_betted_winning || 0
  end

  def is_sub_admin?(role)
    is_sub_admin_tab?(role) || @user.is_sub_admin?
  end

  def fund_transfer_limit
    NumberService.round_to_8_decimal(GammabetSetting.fund_transfer_limit)
  end

  def fetch_admin_market_type(uid)
    return 'Inplay' if Constants::INPLAY_MARKETS.include?(uid)

    'Prematch'
  end

  def user_wallet_limit
    GammabetSetting.user_wallet_limit
  end

  def bet_slip_count
    bet_slips = Rails.cache.fetch(Utility::Cache.player_bet_slips_cache_key(current_user&.id)) { [] }
    bet_slips.count
  end

  def user_balance
    number_with_precision(current_user.available_amount, precision: 2)
  end

  def countries_list(countries, kind)
    kind == 'show all' ? countries : countries.limit(10)
  end

  def sport_country_tournaments(sport_id, country_id)
    Tournament.active_tournaments_with_number_of_matches
              .filter_by_sport(sport_id)
              .filter_by_country(country_id)
              .sort_by_rank
  end

  def custom_running_time(running_time)
    if running_time.instance_of? String
      running_time.gsub(' H', ' Half')
                  .gsub(' P', ' Period')
                  .gsub(' S', ' SET')
                  .gsub(' Q', ' Quarter')
                  .gsub('FT', ' Full Time')
    else
      running_time
    end 
  end

  def bet_label(status)
    case status
    when 'lost'
      'danger'
    when 'won'
      'success'
    when 'pending'
      'warning'
    else
      'default'
    end
  end

  def is_file_image?(file)
    return (file.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/) rescue false
    false
  end
end
