class AddMetamaskAddressIntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :metamask_address, :string
  end
end
