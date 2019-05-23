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
    let(:user2) { create :user }
    let(:task) { create :task, author: user }
    let(:task2) { create :task, author: user2 }

    it { should be_able_to :create, Task }

    it { should be_able_to :update, task }
    it { should_not be_able_to :update, task2 }
  end

  describe 'for executor' do
  end
end
