class AddQuestionsReference < ActiveRecord::Migration[5.2]
  def up
    remove_column :security_answers, :question_number
    add_reference :security_answers, :security_question, foreign_key: true, index: true
  end

  def down
    add_column :security_answers, :question_number, :string
    remove_reference :security_answers, :security_question, foreign_key: true, index: true
  end
end
