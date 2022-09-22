class AddIndexForMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    add_index :match_outcomes, %I[match_uid market_uid]
    add_index :match_outcomes,
      %I[match_uid market_uid outcomeable_uid outcomeable_type],
      name: :index_match_outcomes_on_uides
  end
end
