class CreateSportCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :sport_countries do |t|
      t.integer :sport_id
      t.integer :country_id
      t.integer :number_of_matches, default: 0

      t.timestamps
    end
  end
end
