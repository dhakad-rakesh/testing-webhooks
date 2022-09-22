class AddSummaryTypeToBettingSummary < ActiveRecord::Migration[5.2]
  def change
    add_column :betting_summaries, :summary_type, :integer, default: 0
  end
end
