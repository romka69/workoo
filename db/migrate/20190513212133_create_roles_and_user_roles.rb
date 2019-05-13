class CreateRolesAndUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role, null: false, default: 'customer'

      t.timestamps
    end

    create_table :user_roles do |t|
      t.integer :user_id, null: false
      t.integer :role_id, null: false

      t.timestamps
    end

    add_index :user_roles, [:user_id, :role_id], unique: true
  end
end
