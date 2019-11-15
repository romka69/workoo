class AddReferenceFromUsersToTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :executor_id

    add_reference :tasks, :executor, foreign_key: { to_table: :users }
  end
end
