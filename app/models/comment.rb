class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :task

  EDIT_TIME = 5.minutes

  def edit_time_not_left?
    Time.now.utc - self.updated_at.utc <= EDIT_TIME
  end
end
