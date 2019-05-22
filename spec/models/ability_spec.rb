require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Task }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for customer' do
    let(:user) { create :user }

    it { should be_able_to :manage, Task }
  end

  describe 'for executor' do
  end
end
