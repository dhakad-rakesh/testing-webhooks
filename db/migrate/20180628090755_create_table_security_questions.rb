class CreateTableSecurityQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :security_questions do |t|
      t.string :question
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
