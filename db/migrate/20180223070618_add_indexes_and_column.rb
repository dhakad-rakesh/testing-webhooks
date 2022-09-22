class AddIndexesAndColumn < ActiveRecord::Migration[5.2]
  def change
    add_index :team_tournaments, %I[team_id tournament_id]
    add_index :competitors, %I[team_id match_id]
    add_index :matches, :schedule_at
    add_column :competitors, :qualifier, :string
  end
end
