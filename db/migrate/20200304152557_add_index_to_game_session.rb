class AddIndexToGameSession < ActiveRecord::Migration[5.2]
  def change
    add_index :game_sessions, :session_id
    add_index :session_transactions, :game_session_id
    add_index :session_transactions, [:game_session_id, :transaction_id], name: 'index_game_session_transaction'
    add_index :session_transactions, [:game_session_id, :transaction_id, :bet_type], name: 'index_game_session_transaction_bet_type'
    add_index :session_transactions, [:game_session_id, :bet_transaction_id], name: 'index_game_session_bet_transaction'
    add_index :matches, :status
  end
end
