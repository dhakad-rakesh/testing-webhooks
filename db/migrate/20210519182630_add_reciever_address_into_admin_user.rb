class AddRecieverAddressIntoAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :reciever_address, :string
  end
end
