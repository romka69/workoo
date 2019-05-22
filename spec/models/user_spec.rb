require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :role }

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
end
