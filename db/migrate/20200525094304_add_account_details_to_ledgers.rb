class AddAccountDetailsToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :account_details, :string
  end
end
