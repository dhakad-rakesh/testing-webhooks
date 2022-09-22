class AddVisibleToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :visible, :boolean, default: true
  end
end
