class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :user, foreign_key: true, null: false
      t.references :task, foreign_key: true, null: false

      t.timestamps
    end

    add_index :bids, [:user_id, :task_id], unique: true
  end
end
