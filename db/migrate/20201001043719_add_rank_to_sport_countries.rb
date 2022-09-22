class AddRankToSportCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :sport_countries, :rank, :integer, default: nil, index: true
  end
end
