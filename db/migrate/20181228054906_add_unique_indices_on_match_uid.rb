class AddUniqueIndicesOnMatchUid < ActiveRecord::Migration[5.2]
  def change
    remove_index :matches, :uid
    add_index :matches, :uid, unique: true
  end
end
