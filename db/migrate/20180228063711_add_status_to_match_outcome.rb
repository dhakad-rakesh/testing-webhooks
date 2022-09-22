class AddStatusToMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    add_column :match_outcomes, :status, :string
  end
end
