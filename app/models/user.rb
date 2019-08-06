class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[yandex google_oauth2]

  belongs_to :role

  has_many :tasks, foreign_key: 'author_id', dependent: :nullify
  has_many :comments, foreign_key: 'author_id', dependent: :nullify
  has_many :bids, dependent: :destroy
  has_many :targets, through: :bids, source: :task
  has_many :authorizations, dependent: :destroy

  def customer?
    self.role["role_name"] == "customer"
  end

  def executor?
    self.role["role_name"] == "executor"
  end

  def not_selected?
    self.role["role_name"] == "not selected"
  end

  def author_of?(resource)
    resource.author_id == id
  end

  def have_bid?(task)
    targets.exists?(task.id)
  end

  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
  end
end
