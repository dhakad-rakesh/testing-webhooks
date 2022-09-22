class CreateTableSessionLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :session_logs do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
