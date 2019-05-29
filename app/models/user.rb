class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  has_many :tasks, foreign_key: 'author_id', dependent: :nullify
  has_many :comments, foreign_key: 'author_id', dependent: :nullify
  has_many :bids, dependent: :destroy
  has_many :targets, through: :bids, source: :task

  def customer?
    self.role["role_name"] == "customer"
  end

  def executor?
    self.role["role_name"] == "executor"
  end

  def author_of?(resource)
    resource.author_id == id
  end

  def have_bid?(task)
    targets.exists?(task.id)
  end
end
