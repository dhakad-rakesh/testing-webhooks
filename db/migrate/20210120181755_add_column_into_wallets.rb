class AddColumnIntoWallets < ActiveRecord::Migration[5.2]
  def change
    add_column :wallets, :losing_bonus_amount, :float, default: 0.0
  end
end
