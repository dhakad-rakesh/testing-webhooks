class AddDisplayNameToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :display_name, :string
  end
end
