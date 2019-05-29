require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Task }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for customer and executor' do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:task) { create :task, author: user }
    let(:comment) { create :comment, task: task, author: user }
    let(:comment2) { create :comment, task: task, author: user2 }

    it { should be_able_to :create, Comment }

    it { should be_able_to :update, comment }
    it { should_not be_able_to :update, comment2 }
  end

  describe 'for customer' do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:task) { create :task, author: user }
    let(:task2) { create :task, author: user2 }
    let(:user3) { create :user, :executor }
    let(:bid) { create :bid, user: user3, task: task }

    it { should be_able_to :create, Task }

    it { should be_able_to :update, task }
    it { should_not be_able_to :update, task2 }

    it { should be_able_to :approve_executor, bid }
  end

  describe 'for executor' do
    let(:user) { create :user, :executor }

    it { should be_able_to :create, Bid }
    it { should be_able_to :destroy, Bid }
  end
end
