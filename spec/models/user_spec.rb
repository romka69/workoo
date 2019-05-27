require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :role }
  it { should have_many(:tasks).with_foreign_key('author_id').dependent(:nullify) }
  it { should have_many(:comments).with_foreign_key('author_id').dependent(:nullify) }

  let!(:customer) { create :user }
  let!(:executor) { create :user, :executor }

  describe '#customer?' do
    it 'true' do
      expect(customer).to be_customer
    end

    it 'false' do
      expect(executor).to_not be_customer
    end
  end

  describe '#executor?' do
    it 'true' do
      expect(executor).to be_executor
    end

    it 'false' do
      expect(customer).to_not be_executor
    end
  end

  describe '#author_of' do
    let!(:customer2) { create :user }
    let!(:task) { create :task, author: customer2 }

    it 'true' do
      expect(customer2).to be_author_of(task)
    end

    it 'false' do
      expect(customer).to_not be_author_of(task)
    end
  end
end
