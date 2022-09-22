class AddRankToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :rank, :integer
  end
end
