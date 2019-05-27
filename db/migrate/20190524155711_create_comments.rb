class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :author, foreign_key: { to_table: :users }
      t.references :task, foreign_keys: true

      t.timestamps
    end
  end
end
