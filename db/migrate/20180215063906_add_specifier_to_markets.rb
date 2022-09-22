class AddSpecifierToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :is_specifier_market, :boolean
  end
end
