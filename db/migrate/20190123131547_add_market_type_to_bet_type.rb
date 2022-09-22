class AddMarketTypeToBetType < ActiveRecord::Migration[5.2]
  def change
    add_column :bet_types, :market_type, :integer, default: 0
  end
end
