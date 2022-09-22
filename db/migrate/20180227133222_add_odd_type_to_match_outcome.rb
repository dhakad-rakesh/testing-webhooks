class AddOddTypeToMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    add_column :match_outcomes, :odd_type, :string
  end
end
