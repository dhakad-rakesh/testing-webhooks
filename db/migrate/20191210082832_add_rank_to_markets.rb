class AddRankToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :rank, :integer
  end
end
