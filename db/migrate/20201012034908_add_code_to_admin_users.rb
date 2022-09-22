class AddCodeToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :code, :string
    add_index :admin_users, :code, unique: true
  end
end
