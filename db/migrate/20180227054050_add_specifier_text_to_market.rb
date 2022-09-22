class AddSpecifierTextToMarket < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'
    add_column :markets, :specifier_text, :hstore
  end
end
