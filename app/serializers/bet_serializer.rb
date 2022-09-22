class BetSerializer < BaseSerializer
  attributes :id, :odds, :stake, :status, :market_name, :outcome_name,
             :play_number, :player_name, :team_name, :period, :date, :to_win, :tournament_name,
             :country, :continent, :cashout_amount, :current_odds, :match_title, :final_score, :bet_type_filter,
             :play_type_filter, :combo_bet_id, :combo_bet_odd, :combo_bet_stake, :cashoutable, :is_cashoutable, :recent_match_bet,
             :cashed_out_amount, :running_time, :schedule_at, :full_and_half_time_score, :match_status, :sport_icon_url, :to_return, :type,
             :market_uid, :outcome_id, :market_category_name, :match_id, :match_uid

  delegate :cashout_amount, to: :object
  delegate :current_odds, to: :object

  def odds
    object.odds&.to_f.round(6)
  end

  def recent_match_bet
    (object.match.schedule_at - Time.zone.now) <= 5.minutes
  end

  def date
    object.created_at
  end

  def combo_bet_odd
    object.combo_bet&.odds
  end

  def combo_bet_stake
    object.combo_bet&.stake
  end

  def tournament_name
    object.tournament&.name
  end

  def match_title
    object.match.title
  end

  def final_score
    object.final_score
  end

  def is_cashoutable
    object.cashoutable?
  end

  delegate :cashoutable, to: :object

  def running_time
    match = object.match
    if match.in_progress?
      return match.running_time == 0 || match.running_time.blank? ? 'NA' : match.running_time
    end

    'NA'
  end

  def schedule_at
    object.match.schedule_at
  end

  def full_and_half_time_score
    object.full_and_half_time_score
  end

  def match_status
    object.match.status
  end

  def outcome_name
    object.sort_outcome_name_with_handicap
  end


  def type
    object.class.name
  end

  def status
    I18n.t("bets.status.#{object.status}")
  end

  def outcome_id
    object&.outcome_id&.to_s
  end

  def match_uid
    object.match.uid
  end

  def sport_icon_url
    "#{ENV['DOMAIN_URL']}#{ActionController::Base.helpers.asset_path("sports_icon/api/#{object.match.sport.uid}")}" rescue nil
  end
end
