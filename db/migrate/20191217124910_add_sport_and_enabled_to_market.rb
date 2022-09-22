class AddSportAndEnabledToMarket < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :enabled, :boolean, default: true
  end
end
