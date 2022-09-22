class AddWageredAmountIntoWallet < ActiveRecord::Migration[5.2]
  def change
    add_column :wallets, :wagered_amount, :float, default: 0.0
  end
end
