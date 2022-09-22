class BettingPool < ApplicationRecord
  # After add of match we set the last_match_id (find details on the method)
  has_and_belongs_to_many :matches, after_add: :touch_updated_at
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :bets, dependent: :nullify
  has_many :accumulator_bets, dependent: :nullify
  belongs_to :last_match, class_name: 'Match', foreign_key: 'last_match_id', optional: true

  enum status: { opened: 0, closed: 1, resolved: 2 }
  enum winnings_distribution_method: { top1: 0, top2: 1, top3: 2, top50percent: 3 }

  validates :name, :entry_amount, :points_per_user,
    :minimum_participants, presence: true

  after_touch :set_last_match

  private

  def touch_updated_at(_match)
    touch if persisted? # rubocop:disable Rails/SkipsModelValidations
  end

  # This last match is used to change the status of pool so that when last match
  # starts pool enter will be closed
  def set_last_match
    return if matches.blank?
    self.last_match = matches.order(:schedule_at).last
    save!
  end
end
