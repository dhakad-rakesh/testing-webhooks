class MatchOutcome < ApplicationRecord
  belongs_to :outcomeable, polymorphic: true
  belongs_to :market
  belongs_to :match
  has_many :teams, through: :match
  has_many :team_players, through: :teams
  has_many :bets, dependent: :restrict_with_exception

  before_create :set_relevent_uids

  store :outcome, coder: Hash, accessors: %I[result void_factor]
  store :settings, coder: Hash, accessors: %I[identifier market_status]

  def identifier
    super || {}
  end

  # market_status 1 means available for betting other status means betting is not allowed.
  # TODO: Explore more market status in more details
  def market_status
    super || '0'
  end

  def set_relevent_uids
    self.match_uid = match.uid
    self.market_uid = market.uid
    self.outcomeable_uid = outcomeable.uid
  end
end
