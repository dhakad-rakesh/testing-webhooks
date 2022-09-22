class CreateJoinTableGroupUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :groups, :users do |t|
      t.index %i[group_id user_id]
      t.index %i[user_id group_id]
    end
  end
end
