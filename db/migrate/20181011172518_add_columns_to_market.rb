class AddColumnsToMarket < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :bet_type, :string
    add_column :markets, :play_type, :string
  end
end
