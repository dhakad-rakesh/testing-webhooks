class AddCategoryToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :category, :string
  end
end
