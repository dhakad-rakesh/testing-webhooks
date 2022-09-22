class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :acronym
      t.string :uid, index: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
