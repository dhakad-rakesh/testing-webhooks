class AddApprovedToLedger < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :approved, :boolean, default: true
  end
end
