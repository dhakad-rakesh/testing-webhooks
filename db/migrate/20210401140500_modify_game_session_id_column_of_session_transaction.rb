class ModifyGameSessionIdColumnOfSessionTransaction < ActiveRecord::Migration[5.2]
  def up
    remove_column :session_transactions, :game_session_id, :integer
    add_column :session_transactions, :game_session_id, :string
  end

  def down
    remove_column :session_transactions, :game_session_id, :string
    add_column :session_transactions, :game_session_id, :integer
  end
end
