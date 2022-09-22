class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

    add_index :friend_requests, %I[user_id friend_id], unique: true
  end
end
