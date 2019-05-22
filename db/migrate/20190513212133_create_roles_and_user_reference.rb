class CreateRolesAndUserReference < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role_name, null: false

      t.timestamps
    end

    add_reference :users, :role
    add_foreign_key :users, :roles
  end
end
