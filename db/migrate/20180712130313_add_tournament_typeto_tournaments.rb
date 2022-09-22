class AddTournamentTypetoTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :tournament_type, :integer, default: 0
  end
end
