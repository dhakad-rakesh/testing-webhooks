class DeleteOddsSummary < ActiveRecord::Migration[5.2]
  def change
    drop_table :odds_summaries # rubocop:disable Rails/ReversibleMigration
  end
end
