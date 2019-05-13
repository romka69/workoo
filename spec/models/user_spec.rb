require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_roles).dependent(:destroy) }
  it { should have_many(:roles).through(:user_roles) }
end
