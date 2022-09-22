class AddSymbolToLanguages < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :symbol, :string
    add_column :languages, :is_default, :boolean, default: false
  end
end
