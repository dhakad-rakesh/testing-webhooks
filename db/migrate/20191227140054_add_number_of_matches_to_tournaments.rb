class AddNumberOfMatchesToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :number_of_matches, :integer, default: 0
  end
end
