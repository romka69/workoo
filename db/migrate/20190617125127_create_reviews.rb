class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :for_user, foreign_key: { to_table: :users }
      t.references :by_user, foreign_key: { to_table: :users }
      t.references :task, foreign_keys: true
      t.text :body, null: false

      t.timestamps
    end

    add_index :reviews, [:by_user_id, :for_user_id, :task_id], unique: true

    add_column :tasks, :executor_id, :integer, default: 0
  end
end
