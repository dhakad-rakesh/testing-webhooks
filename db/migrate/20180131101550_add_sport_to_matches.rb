class AddSportToMatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :matches, :sport, foreign_key: true, index: true
  end
end
