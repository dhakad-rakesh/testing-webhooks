class RemoveForeignKeyConstraintFromMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :match_outcomes, :outcomes
  end
end
