class SessionTransaction < ApplicationRecord
  belongs_to :user, foreign_key: :player_id
  belongs_to :game_session, optional: :true
  has_many :ledgers, foreign_key: :transaction_id, primary_key: :transaction_id
  scope :bet_types, -> { where(bet_type: 'bet') }
  scope :win_types, -> { where(bet_type: 'win') }
  scope :debit_types, -> { where(bet_type: 'debit') }
  scope :credit_types, -> { where(bet_type: 'credit') }
  scope :refund_types, -> { where(bet_type: 'refund') }
  belongs_to :casino_item, foreign_key: :game_uuid, primary_key: :uuid, optional: :true
  has_many :ledgers, foreign_key: :transaction_id, primary_key: :transaction_id

  BET_TYPES = [
    BET = 'bet',
    WIN = 'win',
    REFUND = 'refund'
  ].freeze

  scope :between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :joins_casino_item, -> { joins('INNER JOIN casino_items
                                        ON session_transactions.game_uuid = casino_items.uuid
                                        INNER JOIN users
                                        ON CAST(session_transactions.player_id AS INT) = users.id
                                        INNER JOIN casino_menus
                                        ON casino_items.casino_menu_id = casino_menus.id
                                        INNER JOIN ledgers
                                        ON session_transactions.transaction_id = ledgers.transaction_id')
                                }
  scope :joins_slot_game, -> { joins('INNER JOIN slot_games
                                        ON session_transactions.game_uuid = slot_games.uuid
                                        INNER JOIN users
                                        ON CAST(session_transactions.player_id AS INT) = users.id
                                        INNER JOIN ledgers
                                        ON session_transactions.transaction_id = ledgers.transaction_id')
                                }

  scope :transactions_for, -> (type) { joins(:ledgers)
                            .where(bet_type: type, status: 'success', ledgers: {transaction_type: type})
                            }

  scope :by_casino_type, -> (type) { joins(:casino_item).where(casino_items: { casino_menu_id: CasinoMenu.send(type).ids }) }
  scope :by_slot_game_type, -> (type) { joins(:slot_games) }

  scope :stake_by_user, -> (user) { joins_casino_item.where(users: {id: user.id}, bet_type: :bet, status: :success) }

  enum game_type: { casino: 0, slot_game: 1 }.freeze

  def is_failed?
    status == 'failed'
  end

  def is_success?
    status == 'success'
  end
end


