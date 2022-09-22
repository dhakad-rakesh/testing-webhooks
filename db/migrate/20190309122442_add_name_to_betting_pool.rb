class AddNameToBettingPool < ActiveRecord::Migration[5.2]
  def self.up
    add_column :betting_pools, :name, :string
  end

  def self.down
    remove_column :betting_pools, :name
  end
end
