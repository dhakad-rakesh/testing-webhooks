class AddJerseyToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :team_players, :jersey_number, :string
  end
end
