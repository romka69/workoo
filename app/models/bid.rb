class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def set_approve
    self.update!(approve: true)
  end
end
