class CreateOccupationsUser < ActiveRecord::Migration[5.2]
  def change
    create_table :occupations_users do |t|
      t.belongs_to :occupation, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
