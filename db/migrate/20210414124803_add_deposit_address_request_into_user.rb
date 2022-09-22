class AddDepositAddressRequestIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deposit_address_request, :boolean, default: false
  end
end
