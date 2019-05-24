class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  has_many :tasks, foreign_key: 'author_id', dependent: :nullify
  has_many :comments, foreign_key: 'author_id', dependent: :nullify

  def customer?
    self.role["role_name"] == "customer"
  end

  def executor?
    self.role["role_name"] == "executor"
  end

  def author_of?(resource)
    resource.author_id == id
  end
end
