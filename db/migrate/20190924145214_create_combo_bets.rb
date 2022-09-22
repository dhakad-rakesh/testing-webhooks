class CreateComboBets < ActiveRecord::Migration[5.2]
  def change
    create_table :combo_bets do |t|
      t.integer :user_id
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
