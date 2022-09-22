class AddExclusionTimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :exclusion_time, :datetime
  end
end
