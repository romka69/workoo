class Review < ApplicationRecord
  belongs_to :for_user, class_name: 'User'
  belongs_to :by_user, class_name: 'User'
  belongs_to :task

  validates :body, presence: true
  validates :by_user_id, uniqueness: { scope: [:for_user_id, :task_id] }

  scope :reviews_for, ->(user) { where("for_user = ?", user) }
end
