class AddIndexToCountryAndTournament < ActiveRecord::Migration[5.2]
  def change
    add_index :countries, :uid, unique: true
    add_index :tournaments, :uid, unique: true
  end
end
