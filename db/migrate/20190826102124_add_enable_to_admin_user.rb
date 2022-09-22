class AddEnableToAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :enable, :boolean, :default => true
  end
end
