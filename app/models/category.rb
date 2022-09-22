class Category < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  has_many :category_joins
  has_many :markets, through: :category_joins,
                     source_type: 'Market',
                     source: :categorizable

  enum kind: {
    market: MARKET = 'market'
  }

  validates :name, presence: true
end