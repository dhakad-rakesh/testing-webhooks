class RevertAllCompetitionRelatedTables < ActiveRecord::Migration[5.2]
  TABLE_NAMES = %I[bets_competitions participants
                   competitions betting_summaries].freeze
  def self.up
    TABLE_NAMES.each do |table|
      drop_table table
    end
  end

  def self.down
    TABLE_NAMES.each do |table|
      create_table table do |t|
        t.timestamps
      end
    end
  end
end
