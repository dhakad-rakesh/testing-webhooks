class RenameAddressToStreetAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :address, :street_address
  end
end
