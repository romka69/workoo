class AddReferenceFromTaskToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :author, foreign_key: { to_table: :users }
  end
end
