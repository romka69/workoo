class Task < ApplicationRecord
  validates :title, :body, :price, presence: true

  belongs_to :author, class_name: 'User'
end
