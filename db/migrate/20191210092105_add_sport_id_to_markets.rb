class AddSportIdToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :sport_id, :integer
  end
end
