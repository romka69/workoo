class AddApproveToBids < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :approve, :boolean, default: false
  end
end
