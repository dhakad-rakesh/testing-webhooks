class AddSpecifierDataToMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'
    add_column :match_outcomes, :specifier_text, :hstore
  end
end
