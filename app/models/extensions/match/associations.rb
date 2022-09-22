module Extensions
  module Match
    module Associations
      extend ActiveSupport::Concern

      included do
        has_many :competitors, dependent: :nullify
        has_many :teams, through: :competitors
        has_many :team_players, through: :teams
        has_one :venue, dependent: :destroy
        has_and_belongs_to_many :betting_pools
        has_many :match_outcomes, dependent: :nullify
        has_many :outcomes, through: :match_outcomes
        has_many :bets # rubocop:disable Rails/HasManyOrHasOneDependent
        has_many :markets, -> { distinct }, through: :bets
        has_many :users, -> { distinct }, through: :bets
        belongs_to :sport
        belongs_to :tournament
        belongs_to :season, optional: true
        has_many :active_markets, ->(object) { enable.where.not(id: object.inactive_market_ids).distinct },
          through: :match_outcomes, source: :market

        # To mimick has one association with pools
        def betting_pool
          betting_pools.first
        end
      end
    end
  end
end
