class AddSettingsToMarket < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :settings, :text
  end
end
