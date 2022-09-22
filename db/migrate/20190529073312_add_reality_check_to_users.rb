class AddRealityCheckToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :reality_check_timer, :time
  end
end
