require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :price }
  it { should validate_numericality_of :price }

  it { should belong_to :author }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:bids).dependent(:destroy) }
  it { should have_many(:members).through(:bids) }

  describe '#set_complete' do
    let(:task) { create :task, :with_author }
    let(:task2) { create :task, :with_author }
    let(:user) { create :user, :executor }
    let(:bid) { create :bid, task: task2, user: user }

    it 'not complete without bids' do
      task.set_complete

      expect(task.completed).to_not eq true
    end

    it 'not complete without approve bid' do
      task2.set_complete

      expect(task.completed).to_not eq true
    end

    it 'complete' do
      bid.update!(approve: true)
      task2.set_complete

      expect(task2.completed).to eq true
    end
  end
end
