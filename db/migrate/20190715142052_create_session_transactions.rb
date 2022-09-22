class CreateSessionTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table  :session_transactions do |t|
      t.integer   :game_session_id,   null: false
      t.decimal   :amount,            null: false
      t.string    :currency
      t.string    :game_uuid,         null: false
      t.string    :player_id,         null: false
      t.string    :transaction_id
      t.string    :session_id
      t.string    :bet_type
      t.string    :bet_transaction_id
      t.string    :game_type,         default: 'casino'
      t.string    :free_spin_id
      t.integer   :quantity
      t.string    :status,            default: 'success'
      t.timestamps
    end
  end
end
