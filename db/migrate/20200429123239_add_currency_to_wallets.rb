class AddCurrencyToWallets < ActiveRecord::Migration[5.2]
  def change
    add_column :wallets, :currency, :integer
  end
end
