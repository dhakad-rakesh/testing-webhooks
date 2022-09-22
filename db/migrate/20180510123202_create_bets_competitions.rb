class CreateBetsCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :bets_competitions do |t|
      t.references :bet, foreign_key: true
      t.references :competition, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
