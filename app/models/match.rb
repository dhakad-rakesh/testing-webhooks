class Match < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  include Extensions::Match::TournamentUtil
  include Extensions::Match::Associations

  SCOPES = %w[live upcoming]
  STATUSES = %w[not_started in_progress ended resolved]
  GS_STATUSES = { 'Cancl.': 'cancelled', 'Susp.': 'suspended', 'Int.': 'interrupted',  'Delayed': 'delayed', 'Aban.': 'abandoned', 'Postp.': 'postponed', 'TBA': 'time to be announced', 'HT': 'half time', 'FT': 'full time', 'P': 'penalty shootout in progress', 'Pen.': 'match finished after penalty shootout', 'ET': 'extra time', 'AET': 'match finished after extra time', 'WO': 'Walkover', 'Awarded': 'Technical loss', 'Break Time': 'break time between extra time periods', '2nd Half': '2nd Half', 'Finished': 'Finished' }.freeze

  GS_STATUSES_FINISHED = %w[Pen. AET WO Finished FT P]
  GS_STATUSES_IN_PROGRESS = ['Half Time', 'HT', '2nd Half', '1st Half', 'started', 'in_progress']
  GS_STATUSES_NOT_STARTED = ['Not Started', '']
  GS_REFUND_CODES = { "4" => "Postponed", "5" => "Cancelled", "6" => "Walkover", "7" => "Interrupted", "8" => "Abandoned",
  "9" => "Retired", "99" => "Removed" }
  GS_NOT_ENDED_CODES = %w[0 1 2]
  # 0 Not Started
  # 1 InPlay
  # 2 TO BE FIXED: game freezes on bet365 inplay and will be update as soon as GS get updated data
  # 3 Ended

  ACTIVE_STATUS = %w(in_progress coverage about_to_start)
  INACTIVE_STATUS = %w(not_started ended cancelled postponed interrupted abandoned)
  CASHOUTABLE_STATES = %w(not_started in_progress coverage about_to_start) # Need to uncomment this for inplay
  ENDED_STATUS = %w(ended cancelled postponed interrupted abandoned)
  # CASHOUTABLE_STATES = %(not_started)
  PLAYABLE_STATUSES = %w(not_started about_to_start in_progress)


  BETTING_STOP_MATCH_STATUSES = %w[4].freeze # 4 => match ended

  serialize :results

  validates :uid, uniqueness: true

  before_create :update_supported_market_uids
  after_save :notify_match_started

  # Figure out a place to notify when liability exceeded

  store :settings, coder: Hash, accessors: %I[inactive_market_ids score team_info pre_match_odds betting_status actual_schedule running_time supported_market_uids current_period live liability_notification_sent]

  scope :sorted, -> { order(:schedule_at) }
  scope :visible, -> { available_matches.where(visible: true) }
  scope :ended, -> { where(status: "ended") }
  scope :available_matches, -> { where.not(status: %w[cancelled ended resolved]) }
  scope :active_matches, -> { available_matches.where(enabled: true) }
  scope :by_tournaments, -> (tournament_ids) { active_matches.where(tournament_id: tournament_ids) }
  scope :between, -> (start_date, end_date) { where(schedule_at: start_date..end_date) }
  scope :active_with_live_matches, -> { live.where(enabled: true) }
  scope :active_with_not_live_matches, -> { active_matches.where.not(status: %w[started in_progress]) }
  scope :favourite_live_matches, -> (favourite_ids) { active_with_live_matches.where(id: favourite_ids).chronological_order_on_time.group_by(&:sport_id) }
  scope :non_favourite_live_matches, -> (favourite_ids) { active_with_live_matches.where.not(id: favourite_ids).chronological_order_on_time.group_by(&:sport_id) }
  scope :live, -> { where(status: %w[started in_progress about_to_start]) }
  scope :upcoming, -> { active_matches.schedulable.where(status: %w[not_started about_to_start]) }
  scope :by_countries, (lambda do |countries|
                          joins(:venue)
                          .where(matches: { venues: { country_name: Match.downcase_countries(countries) } })
                        end)
  scope :active_within_7_days, (lambda do |start_time = nil, end_time = nil|
                                  active_matches.where(
                                    'schedule_at > ? AND schedule_at < ?',
                                    start_time || Time.zone.now,
                                    end_time || Time.zone.today + 6.days
                                  )
                                end)
  scope :upcoming_7_days, (lambda do |start_time = nil, end_time = nil|
                                  active_matches.where(
                                    'schedule_at > ? AND schedule_at < ?',
                                    start_time || Time.zone.now,
                                    end_time || Time.zone.today + 6.days
                                  )
                                end)
  scope :top_five, (lambda do
                      joins(:bets).select('matches.id, matches.settings, matches.sport_id, count(*) as bet_count')
                                  .group(:id, :sport_id)
                                  .order('bet_count desc')
                                  .limit(5)
                    end)
  scope :search, -> (query) { upcoming.where('name ilike ?', "%#{query}%") }
  scope :chronological_order_on_time, -> { sort_by(&:schedule_at) }
  scope :schedulable, -> { where('schedule_at >= ?', Time.now).order(:schedule_at) }
  scope :available_to_resolve, -> { where(status: %w(ended cancelled postponed interrupted abandoned)) }
  scope :recent_by_date, -> (date=Time.zone.now-2.day) { where(schedule_at: (date)..Time.zone.now) }
  scope :prematch, -> { where(inplay_subscribed: false) }
  scope :inplay, -> { where(inplay_subscribed: true) }
  scope :with_active_tournaments, -> { joins(:tournament).where(tournaments: {enabled: true}) }
  scope :sort_by_tournament, ->(zone) { order("DATE(schedule_at AT TIME ZONE '#{zone.presence || 'GMT'}')", 'tournaments.rank') }
  scope :dafault_to_view, -> { where(' ("matches"."status" in (?) AND "matches"."enabled" = ? ) OR ( "matches"."status" = ? AND "matches".inplay_subscribed = ?)', %w(not_started about_to_start), true, 'in_progress', true)}
  # Will create soccer_match_scores, cricket_match_scores and tennis_match_scores
  %w[soccer cricket tennis].each do |sport|
    has_many "#{sport}_match_scores".to_sym, dependent: :destroy
  end

  class << self
    def highlight
      active_with_not_live_matches.where(highlight: true)
      .sorted
      .limit(15)
    end

    def last_minutes(tournament_ids = active_tournament_ids)
      by_tournaments(tournament_ids)
      .between(DateTime.now, DateTime.now.end_of_day)
      .sorted
      .limit(15)
    end

    def active_tournament_ids
      Tournament.active_tournaments.pluck(:id)
    end

    def fetch_name(home_team, away_team)
      "#{home_team} vs #{away_team}"
    end
  end

  def inactive_market_ids
    super || []
  end

  def score
    super || {}
  end

  def running_time
    super || 0
  end

  def actual_schedule
    super || true
  end

  def pre_match_odds
    super || true
  end

  def live
    super || false
  end

  # betting_status can be 0, 1, 2, 3 and 4
  # where 0 and 1 means betting is allowed, 2 means it is suspended, 3 and 4 means betting is closed.
  def betting_status
    super || ''
  end

  def supported_market_uids
    super || sport.markets.pluck(:uid)
  end

  def qualifier
    info = {}
    team_info&.values&.map { |m| info[m['qualifier']] = m['name'] }
    info
  end

  def load_status(value)
    return value if value.to_s.include?('_')
    'in_progress'
    # match_statuses = Utility::MatchStatusUtility.load_status
    # value = value.is_a?(Integer) ? value : (value.to_s || status).downcase
    # match_status = match_statuses.select do |val|
    #   val.values.flatten.include?(value)
    # end.first
    # match_status.is_a?(Hash) ? match_status.keys.first : 'in_progress'
  end

  def load_gs_status(value)
    return 'not_started' if value.include?(":")
    #Checking if its time(a integer value)
    return 'in_progress' if value.is_i?

    case value

    when 'Cancl.'
      'cancelled'
    when 'Susp.'
      'suspended'
    when 'Int.'
      'interrupted'
    when 'Delayed'
      'delayed'
    when 'Aban.'
      'abandoned'
    when 'Postp.'
      'postponed'
    else
      'unknown'
    end
  end

  def load_ls_status(value)
    case value

    when 1
      'not_started'
    when 2
      'in_progress'
    when 3
      'ended' #'finished'
    when 4
      'cancelled'
    when 5
      'postponed'
    when 6
      'interrupted'
    when 7
      'abandoned'
    when 8
      'coverage'
    when 9
      'about_to_start'  
    else
      'unknown'
    end
  end

  def team_name(competitor)
    competitor.name
  end

  def title
    return name if name.present?
    return '' if team_info.blank?
    match_title = proc { team_info.values.sort_by { |a| a['qualifier'] }.reverse.map { |a| a['name'] }.join(' vs ') }
    cached_title = #Rails.cache.fetch(Utility::Cache.match_title_key(self), expire_in: 1.hour.from_now) do
      match_title.call
    #end
    cached_title.presence || match_title.call
  end

  def self.downcase_countries(countries)
    Array.wrap(countries).map(&:downcase)
  end

  # def supported_market_uids
  #   ::Utility::Sport.info(self).supported_market_uids
  # end

  def in_play?
    started? || in_progress?
  end

  def betting_stopped?
    BETTING_STOP_MATCH_STATUSES.include?(betting_status)
  end

  def started?
    status == "started"
  end

  def not_started?
    status == "not_started"
  end

  def resolved?
    status == "resolved"
  end

  def ended?
    status == "ended"
  end

  def in_progress?
    status == "in_progress"
  end

  def coverage?
    status == "coverage"
  end

  def about_to_start?
    status == "about_to_start"
  end

  def odds_data(market_uids = [])
    if market_uids.present?
      OddStore.new(self.uid).get_multiple_markets(market_uids)
    else
      OddStore.new(self.uid).odds_data
    end
  end

  def firestore_snapshot
    OddsStore::CloudFirestore.read([uid]) rescue nil
  end

  def market_odds_data
    # Rails.cache.fetch(Utility::Cache.odds_change_cache_key(id)) || { markets: {} }
  end

  # For Soccer disable 5 minutes before the start of the event
  def disable_st_markets?
    # return false if sport.uid != '6046' || not_started?
    return true if in_progress?
    schedule_at <= Time.zone.now+5.minutes || about_to_start?
  end

  # For Soccer Disable at the 42nd minute (first Half-time):
  def disable_ht_markets?
    # return false if sport.uid != '6046' || not_started?
    running_time.to_i >= 42 && in_progress?
  end

  # For Soccer Disable at 87` minutes
  def disable_all_inplay_markets?
    # return false if sport.uid != '6046' || not_started?
    running_time.to_i >= 87 && in_progress?
  end

  def disable_prematch_markets?
    about_to_start? || in_progress?
  end

  def player_markets_odds_data
    Rails.cache.fetch(Utility::Cache.odds_change_player_cache_key(id)) || { player_markets: {} }
  end

  def teams_uid(qualifier)
    team_info.select { |_key, value| value['qualifier'] == qualifier }.keys.first.scan(/\d+/)&.first
  end

  def gamecast_url
    "#{Constants::GAMECAST_BASE_URL}season/#{season.uid.scan(/\d+/)&.first}/h2h/" \
      "#{teams_uid('home')}/#{teams_uid('away')}/match/#{uid.scan(/\d+/)&.first}"
  end

  def warehouse_data
    Rails.cache.fetch([:market_all_odds_data, uid], expire_in: 5.minutes) do
      # firebase_client = Firebase::Client.new(Figaro.env.firebase_base_url)
      # firebase_client.get("odds_summary/#{uid}/markets").body
    end
  end

  def activate
    GammabetSetting.allow_betting
    self.actual_schedule = schedule_at if actual_schedule.blank?
    self.schedule_at = Time.zone.now
    self.betting_status = '0'
    self.pre_match_odds = true
    self.enabled = true
    self.status = 'in_progress'
    save
  end

  def enable
    update_column(:enabled, true) unless self.enabled?
  end

  def disable
    update_column(:enabled, false) if self.enabled?
  end

  def bets_for_match(user, type = :traditional)
    bets&.where(user_id: user.id)&.where(bet_type: type)&.order(created_at: :desc)
  end

  def is_live?
    status == 'in_progress'
  end

  def scheduled_time
    if is_live? || ended? 
      running_time.to_i
    else
      time = (schedule_at-Time.zone.now).to_i/60
      time > 0 ? 0 : time.abs
      # return zero as cashout limit is less than 80 minutes.
      # time.abs convert negative value into positive.
    end
  rescue
    90 # value for cashout condition being false.
  end

  def is_scheduled_time_passed?
    schedule_at < Time.zone.now
  end

  def todays?
    schedule_at.to_date == Time.zone.now.to_date
  end

  def arrange_markets_by_ranking
    cached_market_ids = odds_data[:markets].keys
    ordered_markets = {}
    db_order_markets_ids = SportMarket.sport_markets_ids(sport_id: sport_id) & cached_market_ids
    unless db_order_markets_ids === cached_market_ids
      db_order_markets_ids.each do |db_market_id|
        odds_data[:markets].each do |market_id, market_data|
          if db_market_id.to_s == market_id.to_s
            ordered_markets[market_id.to_s] = market_data
          end
        end
      end
      OddStore.new(self.id).odds_data = { markets: ordered_markets }
    end
    odds_data[:markets].except(*SportMarket.disabled_sport_markets_ids(sport_id: sport_id))
  end

  def group_markets_by_category
    market_ids = odds_data[:markets].keys
    markets = Market.includes(:categories).where(uid: market_ids)
    category_names = {}
    markets.each do |market|
      category_names[market.uid] = market.categories.map(&:name)
    end
    grouped_markets = {}
    disabled_markets = fetch_disabled_markets
    odds_data[:markets].each do |market_id, market_data|
      next if disabled_markets[market_id].present?
      if category_names[market_id].blank?
        category_names[market_id] = ['others']
      end
      category_names[market_id].each do |name|
        grouped_markets[name] ||= {}
        grouped_markets[name][market_id] = market_data
      end
    end
    grouped_markets
  end

  def main_markets
    category = Category.find_by_name "main"
    return if category.nil?
    disabled_markets = fetch_disabled_markets
    data = odds_data[:markets]
    result = []

    category.markets.each do |market|
      next if disabled_markets.keys.include? market.uid.to_s
      result << data.dig(market.uid.to_s, "49")
    end
    result.compact
  end

  def fetch_disabled_markets
    disabled_markets = SportMarket.disabled_sport_markets_ids(sport_id: sport_id)
    Hash[disabled_markets.zip disabled_markets]
  end

  Market::CATEGORIES.each do |name|
    define_method("with_#{name}_markets") do
      odds_data = arrange_markets_by_ranking
      unless name === 'all'
        uids = Category.find_by(name: name)
                      .markets.pluck(:uid)
        odds_data = odds_data.slice(*uids)
      end
      
      odds_data.map { |id, odds_data| {id => odds_data} }
    end
  end

  # def markets_ordering(markets, sport_id)
  #   db_order_markets_ids = Market.all_markets_ids(sport_id)
  #   ordered_markets = {}
  #   db_order_markets_ids.each do |db_market_id|
  #     markets.each do |title, market_hash|
  #       market_hash.each do |market_id, market_data|
  #         if db_market_id.to_s == market_id.to_s
  #           ordered_markets[market_id.to_s] = market_data
  #         end
  #       end
  #     end
  #   end
  #   ordered_markets
  # end

  def markets_ordering(markets)
    db_order_markets_ids = Market.markets_enable_ids
    markets.select{ |m| db_order_markets_ids.include?(m[:Id].to_s) }
  end

  def inactive_states?
    Match::INACTIVE_STATUS.include?(status)
  end

  def invalid_scheduled_date?
    Time.zone.now.to_date > schedule_at.to_date
  end

  def format_period(period)
    Constants.format_periods(sport.uid, period)
  end

  def statistics
    Lsports::Format::Statistics.new(self).call
  end

  def market_counts(ignore_ids=[])
    available_market = odds_data[:markets].select{|k,v| v['49'][:status].include?('open')}
    return 0 if available_market.blank?

    ((available_market.keys - ignore_ids) & Market.markets_enable_ids).count
  end

  def current_period
    Lsports::Format::CurrentPeriod.new(self).call
  end

  def display_status
    if %w(cancelled postponed interrupted abandoned).include?(status)
      return 'Void'
    elsif status == 'ended'
      return 'Finished'
    else
      status.gsub('_', ' ').capitalize
    end
  end

  def check_liability_exceeded
    notify_liability_exceeded if liability_exceeded?
  end

  def liability
    bets.sum("stake*cast(odds as decimal)")
  end

  def is_highlightable?
    ENDED_STATUS.exclude? status
  end

  def playable?
    PLAYABLE_STATUSES.include? status
  end

  def is_live?
    ( inplay_subscribed && status == "in_progress" ) rescue false
  end

  private

  def update_supported_market_uids
    self.supported_market_uids = sport.markets.pluck(:uid)
  end

  def notify_match_started
    return unless saved_changes[:status].present? && in_play?
    Notifications::PublishNotificationJob.perform_later(self.id, Constants::NOTIFICATION_KIND[:favourite_match])
  end

  def notify_liability_exceeded
    return unless liability_exceeded? && liability_notification_pending?
    Notifications::PublishNotificationJob.perform_later(self.id, Constants::NOTIFICATION_KIND[:liability_exceeded])
    update(liability_notification_sent: true)
  end

  def liability_exceeded?
    liability >= GammabetSetting.max_liability_amount.to_i
  end

  def liability_notification_pending?
    !liability_notification_sent
  end
end
