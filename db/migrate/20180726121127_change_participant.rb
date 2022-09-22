class ChangeParticipant < ActiveRecord::Migration[5.2]
  def up
    remove_column :participants, :points_pool, :integer
    change_column :participants, :points_gained, :float, default: 0
    change_column :participants, :points_used, :float, default: 0
    add_column :participants, :points_lost, :float, default: 0
  end

  def down
    add_column :participants, :points_pool, :integer
    change_column :participants, :points_gained, :integer
    change_column :participants, :points_used, :integer
    remove_column :participants, :points_lost, :float
  end
end
