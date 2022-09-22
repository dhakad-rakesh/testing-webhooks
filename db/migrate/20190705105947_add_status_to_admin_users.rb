class AddStatusToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :status, :boolean, default: true
  end
end
