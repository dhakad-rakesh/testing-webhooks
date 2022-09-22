class RemovePoolBalanceAndAddWalletInParticipant < ActiveRecord::Migration[5.2]
  def change
    remove_column :participants, :pool_balance, :float
    add_reference :participants, :wallet, index: true
    remove_column :wallets, :locked_amount, :float
  end
end
