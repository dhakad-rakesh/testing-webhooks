class RemoveUidIndexFromTournament < ActiveRecord::Migration[5.2]
  def change
    remove_index :tournaments, :uid
  end
end
