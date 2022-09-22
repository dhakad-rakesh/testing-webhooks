class AddTrackingIdToLedgers < ActiveRecord::Migration[5.2]
  def up
    add_column :ledgers, :tracking_id, :string
    add_index :ledgers, :tracking_id, unique: true
    Ledger.all.map(&:regenerate_tracking_id)
  end

  def down
    remove_index(:ledgers, column: :tracking_id)
    remove_column :ledgers, :tracking_id
  end
end
