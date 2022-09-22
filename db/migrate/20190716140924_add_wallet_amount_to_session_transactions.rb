class AddWalletAmountToSessionTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :session_transactions, :wallet_balance, :decimal
  end
end
