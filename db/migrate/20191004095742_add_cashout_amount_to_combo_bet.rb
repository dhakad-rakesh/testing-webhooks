class AddCashoutAmountToComboBet < ActiveRecord::Migration[5.2]
  def change
    add_column :combo_bets, :cashout_amount, :float
  end
end
