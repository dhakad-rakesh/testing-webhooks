class Popup < ApplicationRecord
  validates_presence_of :title, :country_ids, :screen, :status, :platform
  
  enum screen: {
    home:        HOME        = 'home',
    sports:      SPORTS      = 'sports',
    live:        LIVE        = 'live',
    casino:      CASINO      = 'casino',
    live_casino: LIVE_CASINO = 'live_casino',
    poker:       POKER       = 'poker',
    deposit:     DEPOSIT     = 'deposit',
    withdrawal:  WITHDRAWAL  = 'withdrawal'
  }
  
  enum status: {
    published: PUBLISHED = 'published',
    inactive:  INACTIVE  = 'inactive',
    trash:     TRASH     = 'trash'
  }

  enum platform: {
    web:    WEB    = 'web',
    mobile: MOBILE = 'mobile',
    both:   BOTH   = 'both'
  }

  enum repeat_type: {
    once:       ONCE       = 'once',
    once_a_day: ONCE_A_DAY = 'once_a_day',
    custom:     CUSTOM     = 'custom'
  }

  scope :order_by_recent, -> { order(updated_at: :desc) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) }
  scope :valid_between, ->(start_date, end_date) { where('start_date <= ? AND end_date >= ?', start_date, end_date) }
  scope :todays, -> { valid_between(Date.today, Date.today) }
  scope :by_country_id, ->(country_id) { where("'#{country_id}' = ANY(country_ids)") }
  scope :live_now, -> { published.todays.order_by_recent.uniq(&:screen) }
end
