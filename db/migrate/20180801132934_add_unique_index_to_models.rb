class AddUniqueIndexToModels < ActiveRecord::Migration[5.2]
  TABLES = %I[tournaments seasons sports team_players teams].freeze

  def up
    TABLES.each do |table|
      remove_index table, :uid
      add_index table, [:uid], unique: true
    end
  end

  def down
    TABLES.each do |table|
      remove_index table, :uid
      add_index table, [:uid]
    end
  end
end
