class ComboBet < ApplicationRecord
  include Cashoutable::Combo

  has_many :bets
  belongs_to :user
  has_many :ledgers, as: :betable, dependent: :destroy
  scope :resolved, -> { where(status: %w[won lost refunded cashed_out]) }
  enum status: { pending: 0, won: 1, lost: 2, refunded: 3, hold: 4, cashed_out: 5, cancelled: 6 }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :live, -> { joins(bets: :match).pending.distinct.where(bets: { matches: { status: 'in_progress'} } ) }
  scope :search_by_stake, ->(min, max) { where(stake: min..max) }
  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :won_amount, -> { won.sum('CAST(odds as decimal)*stake') }
  scope :cashed_out_amount, -> { cashed_out.sum(:cashout_amount) }
  scope :settled, -> { where(status: %w[won lost cashed_out]) }

  scope :filter_between_winnings, ->(min_amt, max_amt) {
    won.where("( CAST(combo_bets.odds as decimal) * combo_bets.stake ) + combo_bets.betting_bonus BETWEEN #{min_amt} AND #{max_amt}")
  }

  scope :filter_from_winnings, ->(amt) {
    won.where("( CAST(combo_bets.odds as decimal) * combo_bets.stake ) + combo_bets.betting_bonus >= #{amt}")
  }

  scope :filter_to_winnings, ->(amt) {
    won.where("( CAST(combo_bets.odds as decimal) * combo_bets.stake ) + combo_bets.betting_bonus <= #{amt}")
  }

  scope :filter_from_stake, ->(stake) {
    where('combo_bets.stake >= ?', stake)
  }

  scope :filter_to_stake, ->(stake) {
    where('combo_bets.stake <= ?', stake)
  }

  after_save :set_stats, if: :stats_updation_valid?
  # before_create :update_bonus_stake
  after_save :notify_big_win

  def set_stats
    Stats::BetStatsUpdateJob.perform_later(id, true)
  end

  def update_bonus_stake
    BetStats::Update.new(bet: self).update_bonus_stake
  end

  def stats_updation_valid?
    saved_change_to_status? && status.in?(%w[won lost cashed_out])
  end

  class << self

    def to_csv
      attributes = ["ID", "Player ID", "Currency", "Tournament", "Match", "Stake", "Odds", "Status", "Winnings", "Created At"]

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |combo_bet|
          csv << [combo_bet.id, combo_bet.user.user_number, combo_bet.user.current_wallet.currency, "", "", combo_bet.stake.round(2), combo_bet.odds, combo_bet.status.titleize, combo_bet.winning_amount.round(2), combo_bet.created_at.in_time_zone('Moscow')&.strftime('%e %b %Y, %H:%M %a')] 
          combo_bet.bets.each do |bet|
            csv << ["", "", "", bet.tournament.name, bet.match.name, bet.stake.round(2), bet.odds, bet.status, "", ""]
          end
        end
      end
    end

    def monthly_combo_bets
      between(Time.zone.now.beginning_of_month, Time.zone.now)
    end

    def weekly_combo_bets
      between(Time.zone.now.beginning_of_week, Time.zone.now)
    end

    def today_combo_bets
      between(Time.zone.now.beginning_of_day, Time.zone.now)
    end

    def reseller_combo_bets(admin_user)
      joins(:user).where(users: { admin_user_id: admin_user.id })
    end

    def monthly_stake
      monthly_combo_bets.sum(:stake)
    end
  
    def weekly_stake
      weekly_combo_bets.sum(:stake)
    end
  
    def daily_stake
      today_combo_bets.sum(:stake)
    end
    
    def total_winnings
      won_amount - cashed_out_amount
    end
  end

  def total_winning_amount
    bets.map {|bet| bet.stake * bet.odds.to_f}.sum
  end

  def to_win
    (odds * stake).round(8) rescue 0
  end

  def amount
    if won?
      to_win
    elsif cashed_out?
      cashout_amount
    else
      stake
    end
  end

  def winning_amount
    won? ? ((odds.to_f * stake) + betting_bonus) : 0.0
  end

  def cashoutable
    combo_cashout(self)
  end

  def cashoutable?
    if GammabetSetting.cashout_allowed?
      return pending? && allowed_markets? && combo_cashoutable?
    end
    false
  end

  def allowed_markets?
    !bets.map{ |b| b.allowed_markets? }.include?(false)
  end

  def custom_status
    bets.pluck(:status).include?('lost') ? 'lost' : status
  end

  def to_return
    # return 'NA' unless pending?
    bonus = pending? ? calculate_betting_bonus : betting_bonus
    amount = ( (available_odds.to_f * stake) + bonus ).round(8) rescue 'NA'
    return GammabetSetting.user_wallet_limit if amount > GammabetSetting.user_wallet_limit
    amount.to_f
  end

  def available_odds
    availebl_bets = bets.where(status: [:won, :pending])
    return 1 if availebl_bets.blank?
    availebl_bets.pluck(:odds).map{ |o| o.to_f }.reject(&:zero?).inject(:*) rescue 1
  end

  def bet_type
    'Combo'
  end

  def notifiable?
    Constants::NOTIFIABLE_STATUSES.include? status
  end

  def possible_win
    stake * odds.to_f
  end

  def update_betting_bonus!
    self.update(betting_bonus: calculate_betting_bonus)
  end

  def calculate_betting_bonus
    return 0.0 unless GammabetSetting.betting_bonus_allowed?
    filtered_statuses = ( bets.map(&:status).uniq - ["won", "pending"] )
    filtered_odds = bets.map(&:odds).select{ |odd| odd.to_f < Constants::BET_BONUS_MIN_ODDS }
    bonus = 0.0
    win_amount = (stake.to_f * available_odds.to_f).to_f
    if filtered_statuses.blank? && filtered_odds.blank?
      bonus_percentage = (Constants::BET_BONUS_SETTING[available_matches_count][:bonus_percentage] || 0) rescue 0
      bonus = ( (bonus_percentage/100.0) * win_amount ).to_f rescue 0.0
    end
    return bonus.round(6)
  end

  def available_matches_count
    bets.where(status: [:won, :pending]).pluck(:match_id).uniq.count
  end

  private

  def combo_bets_current_odds
    bets.map{ |b| b.current_odds }
  end

  def combo_bets_schedule_dates
    bets.map{ |b| b.match.scheduled_time }.sort.reverse
  end

  def combo_cashoutable?
    return false if bets.map(&:lost?).include?(true)
    return false if bets.map{ |b| b.odds_suspended? }.include?(false)
    return bets.map{ |b| b.bet_cashoutable? && Match::CASHOUTABLE_STATES.include?(b.match.status) }.include?(true)
    false
  end

  def notify_big_win
    return unless saved_changes[:status].present? && won?
    if big_win?
      Notifications::PublishNotificationJob.perform_later(
        self.id, 
        Constants::NOTIFICATION_KIND[:big_win],
        { combo: true }
      )
    end
  end

  def big_win?
    winning_amount >= GammabetSetting.big_win_notification_amount['IQD'].to_i
  end
end
