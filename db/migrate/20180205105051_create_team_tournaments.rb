class CreateTeamTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :team_tournaments do |t|
      t.references :team, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
