class CreateTennisMatchScores < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :tennis_match_scores do |t|
      t.string :status
      t.string :reporting # may be removed in future
      t.string :match_status
      t.string :home_score, index: true
      t.string :away_score, index: true
      t.string :home_gamescore, index: true
      t.string :away_gamescore, index: true
      t.string :current_server
      t.string :tiebreak
      t.hstore :period_scores
      t.references :match, foreign_key: true, index: true

      t.timestamps
    end
    add_index :tennis_match_scores, :period_scores, using: :gin
  end
end
