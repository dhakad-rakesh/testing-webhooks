class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps
    end

    create_table(:admin_users_roles, id: false) do |t|
      t.references :admin_user
      t.references :role
    end

    add_index(:roles, %I[name resource_type resource_id])
    add_index(:admin_users_roles, %I[admin_user_id role_id])
  end
end
