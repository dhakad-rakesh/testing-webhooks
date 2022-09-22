class AddResellerIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_user_id, :integer
  end
end
