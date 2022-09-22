class AddCountryAndContinentToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :country, :string
    add_column :bets, :continent, :string
  end
end
