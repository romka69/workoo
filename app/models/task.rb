class Task < ApplicationRecord
  validates :title, :body, presence: true
  validates :price, numericality: { only_integer: true }, presence: true

  belongs_to :author, class_name: 'User'
end
