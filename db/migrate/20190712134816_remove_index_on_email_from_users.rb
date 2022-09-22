class RemoveIndexOnEmailFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_index :users, :email
  end

  def down
    add_index :users, :email
  end
end
