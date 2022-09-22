class CreateTeamPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :team_players do |t|
      t.string :name
      t.string :player_type
      t.string :nationality
      t.string :gender
      t.string :uid, index: true

      t.timestamps
    end
  end
end
