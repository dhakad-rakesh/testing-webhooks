class CreateGammabetSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :gammabet_settings do |t|
      t.text :settings

      t.timestamps
    end
  end
end
