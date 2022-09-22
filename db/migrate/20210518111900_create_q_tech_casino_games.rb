class CreateQTechCasinoGames < ActiveRecord::Migration[5.2]
  def change
    create_table :q_tech_casino_games do |t|
      t.string  :uid
      t.string  :name
      t.string  :provider
      t.string  :category
      t.boolean :supports_demo
      t.text    :client_types
      t.text    :languages
      t.text    :currencies
      t.text    :supported_devices
      t.boolean :free_spin_trigger

      t.timestamps
    end
  end
end
