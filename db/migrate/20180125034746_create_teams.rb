class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :country_name
      t.string :acronym
      t.string :uid, index: true

      t.timestamps
    end
  end
end
