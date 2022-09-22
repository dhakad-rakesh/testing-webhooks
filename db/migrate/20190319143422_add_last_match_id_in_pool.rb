class AddLastMatchIdInPool < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :betting_pools, :closing_time, :datetime
    rename_column :betting_pools, :total_points, :total_participants
    add_column :betting_pools, :last_match_id, :integer, index: true
    add_column :betting_pools, :minimum_participants, :integer
  end

  def self.down
    add_column :betting_pools, :closing_time, :datetime
    rename_column :betting_pools, :total_participants, :total_points
    remove_column :betting_pools, :last_match_id, :integer
    remove_column :betting_pools, :minimum_participants, :integer
  end
end
