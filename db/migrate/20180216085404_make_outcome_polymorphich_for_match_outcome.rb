class MakeOutcomePolymorphichForMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    rename_column :match_outcomes, :outcome_id, :outcomeable_id
    add_column :match_outcomes, :outcomeable_type, :string
  end
end
