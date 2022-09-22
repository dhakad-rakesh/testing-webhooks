class AddHighlightToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :highlight, :boolean, index: true
  end
end
