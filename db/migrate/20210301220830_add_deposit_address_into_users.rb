class AddDepositAddressIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deposit_address, :string
  end
end
