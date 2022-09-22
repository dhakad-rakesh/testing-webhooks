class Bet < ApplicationRecord
  include Cashoutable::Single
  # Has scope related to betting.
  include BettingStats
  belongs_to :user
  belongs_to :match
  belongs_to :market
  belongs_to :outcome, optional: true
  belongs_to :tournament
  belongs_to :wallet, optional: true
  belongs_to :accumulator_bet, optional: true, touch: true
  belongs_to :betting_pool, optional: true
  belongs_to :combo_bet, optional: true
  delegate :sport, to: :match

  has_many :ledgers, as: :betable, dependent: :destroy

  scope :between, ->(start_date, end_date) { where('bets.created_at BETWEEN ? and ?', start_date.beginning_of_day, end_date.end_of_day) }
  # scope :between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :combo_bets, -> { where("combo_bet_id is not null") }
  scope :not_combo, -> { where(combo_bet_id: nil) }
  scope :search_by_stake, ->(min, max) { where(stake: min..max) }
  scope :holds_by_match_and_market, -> { where(match_id: @match, market_id: market, status: 'hold') }
  scope :live, -> { joins(:match).pending.where(matches: {status: 'in_progress'}) }
  scope :total_winnings, -> { won.sum('CAST(odds as decimal)*stake') }
  enum bet_type: { traditional: 0, accumulator: 6 }
  enum status: { pending: 0, won: 1, lost: 2, refunded: 3, hold: 4, cashed_out: 5, cancelled: 6, half_lost: 7, half_won: 8 }
  store :information, coder: Hash, accessors: %I[identifier market_name outcome_name bet_type_filter play_type_filter
    market_uid market_category_name specifier_name
  ]
  # scope :settled, -> { where(status: %w[won lost cashed_out]) }
  scope :settled, -> { where('bets.status in (?)', %w[won lost cashed_out].map{ |s| Bet.statuses[s] })}
  scope :by_users, ->(ids) { where(user_id: ids) }
  scope :by_sport_kind, (lambda do |kind|
                        joins(:match)
                        .where(matches: { sport_id: Sport.send(kind).ids })
                      end)
  scope :valid_bets_by_admin, ->(id) {
                                       where(status: %w[won lost cashed_out pending])
                                         .joins(:user)
                                         .where('users.admin_updated_at <= bets.created_at AND users.admin_user_id = ?', id)
                                     }
  # Application's profit
  scope :total_profit, -> { settled.sum(:profit) }

  enum play_type: %I[pregame inplay]

  scope :filter_between_winnings, ->(min_amt, max_amt) {
    won.where("CAST(odds as decimal) * stake BETWEEN #{min_amt} AND #{max_amt}")
  }

  scope :filter_from_winnings, ->(amt) {
    won.where("CAST(odds as decimal) * stake >= #{amt}")
  }

  scope :filter_to_winnings, ->(amt) {
    won.where("CAST(odds as decimal) * stake <= #{amt}")
  }

  scope :filter_from_stake, ->(stake) {
    where('stake >= ?', stake)
  }

  scope :filter_to_stake, ->(stake) {
    where('stake <= ?', stake)
  }

  before_validation :set_tournament_information

  delegate :name, to: :tournament

  before_create :set_country_and_continent
  before_create :set_market_and_outcome_information
  after_create :remove_market_liability_cache
  after_save :notify_big_win
  after_create :check_match_liability
  
  before_save :set_stats, if: :stats_updation_valid?
  before_create :update_bonus_stake

  def set_stats
    BetStats::Update.new(bet: self).call
  end

  def update_bonus_stake
    BetStats::Update.new(bet: self).update_bonus_stake unless combo_bet_id?
  end

  def stats_updation_valid?
    status_changed? && status.in?(%w[won lost cashed_out]) && !combo_bet_id?
  end

  class << self

    def to_csv
      attributes = %w{id player_id currency stake odds status winnings bet_type created_at}

      CSV.generate(headers: true) do |csv|
        csv << attributes
        
        all.each do |bet|
          csv << [bet.id, bet.user.user_number, bet.wallet.currency, bet.stake, bet.odds, bet.status.titleize, bet.winnings, bet.bet_type, bet.created_at.in_time_zone('Moscow')&.strftime('%e %b %Y, %H:%M %a')] 
        end
      end
    end

    def monthly_bets
      between(Time.zone.now.beginning_of_month, Time.zone.now)
    end

    def weekly_bets
      between(Time.zone.now.beginning_of_week, Time.zone.now)
    end

    def today_bets
      between(Time.zone.now.beginning_of_day, Time.zone.now)
    end

    def reseller_bets(admin_user)
      joins(:user).where(users: { admin_user_id: admin_user.id })
    end

    def monthly_stake
      monthly_bets.sum(:stake)
    end
  
    def weekly_stake
      weekly_bets.sum(:stake)
    end
  
    def daily_stake
      today_bets.sum(:stake)
    end
  end

  # identifier is key based on which we can identify market and proper outcome
  # with specifier. We have created this based on specifier
  def identifier
    super || {}
  end

  def sport_name
    match.sport.name
  end

  def tournament_name
    match.tournament.name
  end

  def market_name
    begin
      return (super || {}) if super != "Goal Sequence"
      identifier_options = eval identifier
      identifier_options[:handicap]
    rescue StandardError => e
      super || {}
    end
  end

  def formated_market_uid
    specifier_name.present? ? "#{market.uid}^#{specifier_name}" : market.uid.to_s
  end

  def outcome_name
    super || {}
  end

  def bet_type_filter
    super || ''
  end

  def play_type_filter
    super || ''
  end

  def final_score
    match.score.empty? ? 'NA' : match.score
  end

  def full_and_half_time_score
    results = match.results
    if results.present?
      result_1 = results[:Periods].map{ |p| p[:Results] if p[:Type] == 1 || p[:Type] == 10  }.compact.flatten
      result_2 = results[:Periods].map{ |p| p[:Results] if p[:Type] == 2 || p[:Type] == 20 }.compact.flatten
      "#{get_score(result_1)} | #{get_score(result_2)}"
    else
      'NA | NA'
    end
  rescue StandardError => e
    'NA | NA'
  end

  def get_score(results)
    "#{results[0][:Value]}:#{results[1][:Value]}"
  end
  # Calculate cashout amount for a bet which is pending
  # Return stake amount if bet market or outcome is currently inactive
  def cashout_amount
    return if !pending? || accumulator_bet.present?
    cashout_odds_with_status = current_odds_and_status
    cashout_odds = cashout_odds_with_status[:odds]
    market_status = cashout_odds_with_status[:status]
    return stake if !market_status || cashout_odds.blank?
    CashoutService.cashout_value(self, cashout_odds)
  end

  # Fetch current odds for a bet and its status whether its currently active or inactive
  # status is true if bet is active else false
  def current_odds_and_status
    if play_type == "inplay"
      firestore_market_data = match.firestore_snapshot.dig(:market, formated_market_uid.to_s.to_sym) rescue nil 
      return {status: false, odds: nil, odds_status: nil, market_status: nil} if firestore_market_data.blank?
      odds_status = firestore_market_data.dig(:outcomes, outcome_id.to_s.to_sym, :Status)
      status = ( odds_status.present? && odds_status.to_s == "1" )
      data = {
        status: status,
        odds: firestore_market_data.dig(:outcomes, outcome_id.to_s.to_sym, :Price),
        odds_status: Bet.ls_status( odds_status.to_i ),
        market_status: Bet.ls_status( odds_status.to_i )
      }
      return data
    end
    market_data = Utility::MarketUtility.identifier_data(match_id, self.market.uid, identifier)
    # outcome_data = market_data.dig(:outcomes, outcome.name) if market_data.present?
    #outcome_data = market_data.dig(:outcomes).map{|key, hash| hash if (hash[:name] == outcome.name) || (hash[:handicap].present? && hash[:name].gsub(" ", "") == outcome.name)}.compact.first rescue {}
    outcome_data = []
    if market_data.present?
      begin
        # Need to remove this code later when completely move to lsport
        # Begin
        market_data.dig(:outcomes).each do |key, hash|
          identifier_hash = eval identifier.to_s
          if identifier_hash.present?
            if hash[:handicap] == identifier_hash[:handicap] && hash[:name].gsub(" ", "") == outcome.name
              outcome_data << hash
            end
          elsif hash[:name] == outcome.name
            outcome_data << hash
          end
        end
        # End
      rescue Exception => e
        outcome = market_data.dig(:outcomes)[outcome_id.to_s]
        outcome_data << outcome
      end  
    end
    outcome_data = outcome_data.compact.first
    # Need to update fix this too, hint remove 1 and active
    status = outcome_data && market_data[:status].include?('open' || '1') && (outcome_data[:status] == 'open' || outcome_data[:active] == '1')  rescue false
    outcome_status = outcome_data[:status] rescue ""
    market_status = market_data[:status] rescue ""
    { status: status, odds: (outcome_data || {}).dig(:odds)&.to_f&.round(6), odds_status: outcome_status, market_status:  market_status }
  end

  def current_odds
    current_odds_with_status = current_odds_and_status rescue nil
    current_odds_with_status[:status] ? current_odds_with_status[:odds] : nil rescue nil
  end

  def current_statuses
    current_odds_with_status = current_odds_and_status rescue nil
    current_odds_with_status[:status] ? current_odds_with_status.slice(:odds_status, :market_status) : nil rescue nil
  end

  def to_return
    # return 'NA' unless pending?
    (odds.to_f * stake).round(8) rescue 'NA'
  end

  def to_win
    return if accumulator_bet_id.present?
    odds_data = if pending?
             odds.to_f
           elsif hold?
             current_odds.to_f
           end
    return if odds_data.blank?
    (odds_data * stake).round(8) 
  rescue StandardError => e
    0
  end
  
  def winning_amount
    won? ? (odds.to_f * stake) : 0.0
  end

  def bet_type
    combo_bet_id? ? 'Combo' : 'Single'
  end


  def cashoutable?
    if GammabetSetting.cashout_allowed?
      if combo_bet.present?
        return combo_bet.cashoutable?
      else
        return allowed_markets? && pending? && bet_cashoutable? && odds_suspended?
      end
    end
    false
  end

  def allowed_markets?
    # !Constants::UNAVAILABLE_CASHOUT_MARKETS.include?(market.uid)
    true
  end

  def bet_cashoutable?
    return false unless match.enabled?
    return false unless Match::CASHOUTABLE_STATES.include?(match.status)
    return false if match.invalid_scheduled_date?
    true
  end

  def odds_suspended?
    cs = current_statuses || false
    cs && cs[:market_status].include?('open') && cs[:odds_status] == 'open'
  end

  def cashoutable
    single_cashout(self)
  end

  def have_over_under_market?
    Constants::OVER_UNDER_MARKETS.include?(market.uid)
  end

  def self.ls_status(value)
    case value

    when 1
      'open'
    when 2
      'suspended'
    when 3
      'settled'
    else
      'suspended'
    end
  end

  def self.ls_settlement_status(value)
    case value

    when -1
      :cancelled
    when 1
      :lost
    when 2
      :won
    when 3
      :refunded
    when 4
      :half_lost
    when 5
      :half_won
    else
      nil
    end
  end

  def sort_outcome_name_with_handicap
    handicap = specifier_text['handicap']
    o_name = optimse_outcome_name(outcome_name)
    "#{o_name} #{handicap}"
  end

  def optimse_outcome_name(name)
    case name
    when 'Yes'
      'Y'  
    when 'No'
      'N'  
    when 'Under'
      '-'
    when 'Over'
      '+'
    else
      name  
    end
  end

  private

  def set_tournament_information
    self.tournament_id = match.tournament_id if match.present?
  end

  # To store the market name we will not again and again convert the name of
  # markets and outcome
  def set_market_and_outcome_information
    market= Market.find market_id
    self.market_name = self.bet_type_filter = market.name
    self.play_type_filter = ""#market_name + "::" + outcome_name
  end

  def set_country_and_continent
    cun_code = match&.venue&.country_code
    self.country = if Constants::UK_COUNTRY_CODES.keys.map(&:to_s).include?(cun_code)
                     Constants::UK_COUNTRY_CODES[cun_code.to_sym]
                   else
                     ISO3166::Country.find_country_by_alpha3(cun_code)&.name&.downcase
                   end
    self.continent = match&.venue&.continent
  end

  def remove_market_liability_cache
    Rails.cache.delete("market_#{self.market.uid}_liability")
  end

  def notify_big_win
    return unless saved_changes[:status].present? && won?
    if big_win?
      Notifications::PublishNotificationJob.perform_later(self.id, Constants::NOTIFICATION_KIND[:big_win])
    end
  end

  def big_win?
    winnings >= GammabetSetting.big_win_notification_amount['IQD'].to_i
  end

  def check_match_liability
    match.check_liability_exceeded
  end

  def notifiable?
    Constants::NOTIFIABLE_STATUSES.include? status
  end
end
