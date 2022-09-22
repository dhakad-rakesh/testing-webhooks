class AddAdminUpdatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
