class AddCashbackTypeToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :cashback_type, :integer
  end
end
