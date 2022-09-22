class AddClickCountToAdvertisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :click_count, :integer, :default => 0
  end
end
