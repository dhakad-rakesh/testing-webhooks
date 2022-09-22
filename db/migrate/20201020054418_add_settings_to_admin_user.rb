class AddSettingsToAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :settings, :text
  end
end
