class AddNumberOfMatchesToSports < ActiveRecord::Migration[5.2]
  def change
    add_column :sports, :number_of_matches, :integer, default: 0
  end
end
