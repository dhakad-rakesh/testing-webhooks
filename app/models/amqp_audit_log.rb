class AmqpAuditLog < ApplicationRecord
  ROUTING_TYPES = %w[ alive bet_cancel bet_settlement bet_stop fixture_change
                      odds_change rollback_bet_settlement snapshot_complete rollback_bet_cancel].freeze
  before_create :set_audit_informations
  after_create :remove_last_alive_log

  scope :log_of, ->(match) { where(event_id: (match.is_a?(Match) ? match.uid : match)) }

  enum routing_type: ROUTING_TYPES.map { |routing_key_type|
    { routing_key_type.to_sym => routing_key_type }
  }.inject(:merge)

  # alive data comes very frequently so we will remove store only last 20 data
  # and other will be deleted
  def remove_last_alive_log
    AmqpAuditLog.where(routing_key: '-.-.-.alive.-.-.-.-').order(id: :desc)
                .offset(20).destroy_all
  end

  # Method will break routing key and store various information
  # Starting 2 shows priority, next is type of
  # routing key which can be pre or live, their are different routing types
  # (odds_change, bet_settlement, bet_stop, cancelbet, rollback_betsettlement,
  # rollback_cancelbet, fixture_change, product_down, alive)
  # then we have event_id
  # routing_key e.g.
  # hi.low.live.odds_change.1.sr:match.14034261.-
  def set_audit_informations
    self.event_id = routing_key.split('.')[-3, 2].join(':')
    self.log_type = routing_key.split('.').slice(1, 2).join('.')
    self.routing_type = routing_key.split('.')[3]
  end

  def self.run_live_logs(match, only_odds_change = false, is_allowed_sleep = true)
    logs = AmqpAuditLog.log_of(match).where(log_type: ['-.live'])
    logs = logs.odds_change if only_odds_change
    run_simulation(logs.order(:timestamp_in_ms), is_allowed_sleep)
  end

  def self.run_pre_logs(match, is_allowed_sleep = false)
    run_simulation(log_of(match).where(log_type: 'pre.-').order(:timestamp_in_ms), is_allowed_sleep)
  end

  def self.run_simulation(logs, is_allowed_sleep = true)
    logs.each_with_index do |log, index|
      args = [log.xml_data, routing_key = log.routing_key]
      if routing_key.include?('odds_change')
        BR::AMQP::MatchMarketOddsChangeJob.perform_now(*args)
      elsif routing_key.include?('bet_stop')
        BR::AMQP::BetStopJob.perform_now(*args)
      end
      if is_allowed_sleep
        sleep_time = ((logs[index + 1].timestamp_in_ms.to_i - log.timestamp_in_ms.to_i) / 1000)
        sleep(sleep_time) if index < logs.count
      end
    end
  end
end
