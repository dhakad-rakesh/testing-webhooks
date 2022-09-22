class CreateSoccerMatchScores < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :soccer_match_scores do |t|
      t.string :match_status
      t.string :home_score
      t.string :away_score
      t.hstore :clock
      t.hstore :period_scores
      t.hstore :statistics
      t.string :home_corners, index: true
      t.string :away_corners, index: true
      t.references :match, foreign_key: true, index: true

      t.timestamps
    end
    add_index :soccer_match_scores, :clock, using: :gin
    add_index :soccer_match_scores, :statistics, using: :gin
    add_index :soccer_match_scores, :period_scores, using: :gin
  end
end
