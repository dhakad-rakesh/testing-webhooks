class AddTournamentIdToBet < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :tournament_id, :integer
    add_index :bets, :tournament_id
  end
end
