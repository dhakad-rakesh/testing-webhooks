class AddComboBetIdToBet < ActiveRecord::Migration[5.2]
  def up
    add_column :bets, :combo_bet_id, :integer
  end

  def down
    remove_column :bets, :combo_bet_id
  end
end
