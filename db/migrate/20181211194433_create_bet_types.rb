class CreateBetTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :bet_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
