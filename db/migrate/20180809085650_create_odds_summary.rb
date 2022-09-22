class CreateOddsSummary < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'
    create_table :odds_summaries do |t|
      t.references :match, foreign_key: true
      t.string :match_uid
      t.string :outcome_uid
      t.string :market_uid
      t.decimal :odds
      t.decimal :probabilities
      t.string :timestamp
      t.hstore :specifier_text
      t.string :status
      t.string :log_type

      t.timestamps
    end
  end
end
