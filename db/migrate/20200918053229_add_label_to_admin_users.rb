class AddLabelToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :label, :integer, default: 0
  end
end
