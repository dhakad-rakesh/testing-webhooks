class AddPlayTypeToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :play_type, :integer
  end
end
