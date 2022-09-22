class CreateTopicsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :topics_users do |t|
      t.belongs_to :topic, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
