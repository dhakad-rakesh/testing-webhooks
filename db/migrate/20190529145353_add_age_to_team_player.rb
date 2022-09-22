class AddAgeToTeamPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :team_players, :age, :integer, default: 0
  end
end
