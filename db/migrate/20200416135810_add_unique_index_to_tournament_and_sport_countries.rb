class AddUniqueIndexToTournamentAndSportCountries < ActiveRecord::Migration[5.2]
  def change
    add_index :tournaments, [:uid, :country_id], unique: true
    add_index :sport_countries, [:sport_id, :country_id], unique: true
  end
end
