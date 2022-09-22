class CreateCricketMatchScores < ActiveRecord::Migration[5.2]
  def change
    create_table :cricket_match_scores do |t|
      t.string :status
      t.string :home_score
      t.string :reporting
      t.string :match_status
      t.string :away_score
      t.string :delivery
      t.string :innings
      t.string :over
      t.string :home_penalty_runs
      t.string :away_penalty_runs
      t.string :home_dismissals
      t.string :away_dismissals
      t.references :match, foreign_key: true, index: true

      t.timestamps
    end
  end
end
