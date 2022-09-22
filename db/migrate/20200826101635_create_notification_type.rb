class CreateNotificationType < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_types do |t|
      t.string :name
      t.integer :kind, index: true, unique: true
      t.integer :status, default: 0
    end
  end
end
