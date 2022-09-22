class AddRankToSports < ActiveRecord::Migration[5.2]
  def change
    add_column :sports, :rank, :integer, default: 0, index: true
  end
end
