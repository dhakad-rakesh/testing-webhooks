class ChangeGameTypeColumnOfSessionTransaction < ActiveRecord::Migration[5.2]
  def up
    remove_column :session_transactions, :game_type, :string
    add_column :session_transactions, :game_type, :integer, default: 0
  end

  def down
    remove_column :session_transactions, :game_type, :integer
    add_column :session_transactions, :game_type, :string, default: 'casino'
  end
end
