class Task < ApplicationRecord
  validates :title, :body, :price, presence: true
end
