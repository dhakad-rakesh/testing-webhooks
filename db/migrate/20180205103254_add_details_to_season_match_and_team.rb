class AddDetailsToSeasonMatchAndTeam < ActiveRecord::Migration[5.2]
  def change
    add_reference :seasons, :sport, foreign_key: true, index: true
    add_reference :seasons, :tournament, foreign_key: true, index: true
    add_reference :teams, :sport, foreign_key: true, index: true
    add_reference :matches, :tournament, foreign_key: true, index: true
  end
end
