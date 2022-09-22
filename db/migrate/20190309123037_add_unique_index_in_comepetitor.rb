class AddUniqueIndexInComepetitor < ActiveRecord::Migration[5.2]
  def change
    remove_index :competitors, %I[team_id match_id]
    add_index :competitors, %I[team_id match_id], unique: true
  end
end
