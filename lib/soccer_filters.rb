module SoccerFilters
  extend ActiveSupport::Concern
  included do
    scope :first_half, -> { where('name like ?', '%1st%') }
    scope :second_half, -> { where('name like ?', '%2nd%') }
    scope :five_minutes, -> { where('name like ?', '5 minutes%') }
    scope :ten_minutes, -> { where('name like ?', '%10 minutes%') }
    scope :fifteen_minutes, -> { where('name like ?', '%15 minutes%') }
    scope :competitor1, -> { where('name like ?', '%competitor1%') }
    scope :competitor2, -> { where('name like ?', '%competitor2%') }
    scope :all_market, -> { where.not(id: first_half + second_half + five_minutes + ten_minutes + fifteen_minutes) }
  end
  module ClassMethods
    def periods_keys
      [
        { id: 'first_half', name: '1st Half' },
        { id: 'second_half', name: '2nd Half' },
        { id: 'both', name: 'Match' },
        { id: 'five_minutes', name: '5 minutes' },
        { id: 'ten_minutes', name: '10 minutes' },
        { id: 'fifteen_minutes', name: '15 minutes' }
      ]
    end

    def both_markets
      markets = where.not(id: competitor1.pluck(:id) + competitor2.pluck(:id))
      {
        first_half: {
          all: markets.first_half.pluck(:id)
        },
        second_half: {
          all: markets.second_half.pluck(:id)
        },
        both: {
          all: markets.all_market.pluck(:id)
        },
        five_minutes: {
          all: markets.five_minutes.pluck(:id)
        },
        ten_minutes: {
          all: markets.ten_minutes.pluck(:id)
        },
        fifteen_minutes: {
          all: markets.fifteen_minutes.pluck(:id)
        }
      }
    end

    def competitor1_markets
      {
        first_half: {
          all: first_half.competitor1.pluck(:id)
        },
        second_half: {
          all: second_half.competitor1.pluck(:id)
        },
        both: {
          all: all_market.competitor1.pluck(:id)
        },
        five_minutes: {
          all: five_minutes.competitor1.pluck(:id)
        },
        ten_minutes: {
          all: ten_minutes.competitor1.pluck(:id)
        },
        fifteen_minutes: {
          all: fifteen_minutes.competitor1.pluck(:id)
        }
      }
    end

    def competitor2_markets
      {
        first_half: {
          all: first_half.competitor2.pluck(:id)
        },

        second_half: {
          all: second_half.competitor2.pluck(:id)
        },
        both: {
          all: all_market.competitor2.pluck(:id)
        },
        five_minutes: {
          all: five_minutes.competitor2.pluck(:id)
        },
        ten_minutes: {
          all: ten_minutes.competitor2.pluck(:id)
        },
        fifteen_minutes: {
          all: fifteen_minutes.competitor2.pluck(:id)
        }
      }
    end

    def filter_keys
      {
        teams: %w[competitor1 competitor2 both],
        periods: %w[first_half second_half both five_minutes ten_minutes fifteen_minutes],
        filters: %w[all]
      }
    end

    def soccer_filters
      {
        keys: filter_keys,
        periods: periods_keys,
        filters: [
          { name: 'all' }
        ],
        both: both_markets,
        competitor1: competitor1_markets,
        competitor2: competitor2_markets,
        play_type: PlayType.all.map do |pt| # TODO: Remove play type key later.
          PlayTypeSerializer.new(pt)
        end,
        player_bet_type: BetType.player_market.map do |bt|
          BetTypeSerializer.new(bt)
        end,
        bet_type: BetType.non_player_market.map do |bt|
          BetTypeSerializer.new(bt)
        end,
        markets: Market.soccer_supported_markets.map do |market|
          MarketSerializer.new(market)
        end,
        player_markets: Market.soccer_player_markets.map do |market|
          MarketSerializer.new(market)
        end
      }
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
