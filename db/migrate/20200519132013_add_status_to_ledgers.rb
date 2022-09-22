class AddStatusToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :status, :integer, default: 0
  end
end
