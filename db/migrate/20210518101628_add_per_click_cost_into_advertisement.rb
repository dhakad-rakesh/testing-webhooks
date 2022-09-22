class AddPerClickCostIntoAdvertisement < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :per_click_cost, :float, default: 0.0
  end
end
