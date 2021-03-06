class Task < ApplicationRecord
  validates :title, :body, presence: true
  validates :price, numericality: { only_integer: true }, presence: true

  belongs_to :author, class_name: 'User'

  has_many :comments, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :members, through: :bids, source: :user
  has_many :reviews, dependent: :nullify

  def set_complete
    self.update!(completed: true) if self.bids.find_by(approve: true)
  end

  def set_executor(user)
    self.update!(executor_id: user.id)
  end
end
