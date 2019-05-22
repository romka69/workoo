class Role < ApplicationRecord
  has_many :users, dependent: :nullify

  def self.find_role(role)
    Role.find_by(role_name: role)
  end
end
