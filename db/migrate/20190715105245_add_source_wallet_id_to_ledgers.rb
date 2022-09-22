class AddSourceWalletIdToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :source_wallet_id, :integer
  end
end
