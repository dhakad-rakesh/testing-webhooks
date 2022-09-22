class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :title
      t.integer :status, default: 0
      t.integer :competition_category, default: 0
      t.datetime :start_at
      t.datetime :end_at
      t.json :information, default: {}

      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
