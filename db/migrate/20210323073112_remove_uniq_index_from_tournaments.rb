class RemoveUniqIndexFromTournaments < ActiveRecord::Migration[5.2]
  def change
    remove_index :tournaments, :uid
    add_index :tournaments, :uid
  end
end
