class AddUidInMatchOutcomes < ActiveRecord::Migration[5.2]
  def change
    add_column :match_outcomes, :match_uid, :string
    add_column :match_outcomes, :market_uid, :string
    add_column :match_outcomes, :outcomeable_uid, :string
    add_column :match_outcomes, :outcome, :text
  end
end
