class AddUniqueIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, name: "index_users_on_phone"
    add_index :users, :phone, unique: true
  end
end
