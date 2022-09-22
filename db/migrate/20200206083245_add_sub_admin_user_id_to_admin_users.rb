class AddSubAdminUserIdToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :sub_admin_user_id, :integer
  end
end
