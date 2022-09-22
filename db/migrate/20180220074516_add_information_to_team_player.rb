class AddInformationToTeamPlayer < ActiveRecord::Migration[5.2]
  def change
    add_reference :team_players, :team, foreign_key: true, index: true
    add_column :team_players, :full_name, :string
    add_column :team_players, :dob, :datetime
    add_column :team_players, :country_code, :string
  end
end
