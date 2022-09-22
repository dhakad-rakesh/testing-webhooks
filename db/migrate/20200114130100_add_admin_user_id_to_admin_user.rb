class AddAdminUserIdToAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :admin_user_id, :integer
  end
end
