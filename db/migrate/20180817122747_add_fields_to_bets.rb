class AddFieldsToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :team_name, :string
    add_column :bets, :player_name, :string
    add_column :bets, :period, :string
    add_column :bets, :play_number, :string
  end
end
