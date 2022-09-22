class CreateTableSecurityAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :security_answers do |t|
      t.string :question_number
      t.string :answer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
