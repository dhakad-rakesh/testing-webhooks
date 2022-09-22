class AddSeasonToMatch < ActiveRecord::Migration[5.2]
  def change
    add_reference :matches, :season, foreign_key: true, index: true
  end
end
