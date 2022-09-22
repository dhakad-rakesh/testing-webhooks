class AddCasinoMenuIdToQTechCasinoGame < ActiveRecord::Migration[5.2]
  def change
  	add_column :q_tech_casino_games, :casino_menu_id, :integer,  index: true
  end
end
