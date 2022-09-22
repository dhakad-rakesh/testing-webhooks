class AddNameToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :name, :string
  end
end
