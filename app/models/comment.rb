class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :task
end
