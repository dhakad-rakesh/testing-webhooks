class AddOddsAndStakeToComboBet < ActiveRecord::Migration[5.2]
  def change
    add_column :combo_bets, :odds, :float
    add_column :combo_bets, :stake, :float
  end
end
