class AddKindToSports < ActiveRecord::Migration[5.2]
  def change
    add_column :sports, :kind, :string
  end
end
