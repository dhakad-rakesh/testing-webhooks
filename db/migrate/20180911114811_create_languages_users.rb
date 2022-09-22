class CreateLanguagesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :languages_users do |t|
      t.references :language, foreign_key: true
      t.references :user, foreign_key: true
      t.string :nature

      t.timestamps
    end
  end
end
