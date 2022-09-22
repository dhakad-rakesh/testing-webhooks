class AddBetTypeAndPlayTypeInformation < ActiveRecord::Migration[5.2]
  def change
    remove_column :markets, :bet_type, :string
    remove_column :markets, :play_type, :string
    add_column :markets, :bet_type_id, :integer
    add_column :markets, :play_type_id, :integer
  end
end
