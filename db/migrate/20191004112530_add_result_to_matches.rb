class AddResultToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :results, :text
  end
end
