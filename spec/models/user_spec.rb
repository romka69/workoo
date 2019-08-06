require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :role }
  it { should have_many(:tasks).with_foreign_key('author_id').dependent(:nullify) }
  it { should have_many(:comments).with_foreign_key('author_id').dependent(:nullify) }
  it { should have_many(:bids).dependent(:destroy) }
  it { should have_many(:targets).through(:bids) }
  it { should have_many(:authorizations).dependent(:destroy) }

  let!(:customer) { create :user }
  let!(:executor) { create :user, :executor }
  let!(:not_selected) { create :user, :not_selected }

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

  describe '#not_selected?' do
    it 'true' do
      expect(not_selected).to be_not_selected
    end

    it 'false' do
      expect(executor).to_not be_not_selected
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

  describe '#have_bid?' do
    let(:user) { create :user, :executor }
    let(:task) { create :task, author: user }
    let!(:bid) { create :bid, user: user, task: task }
    let(:user2) { create :user, :executor }

    it 'true' do
      expect(user).to be_have_bid(task)
    end

    it 'false' do
      expect(user2).to_not be_have_bid(task)
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create :user }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'yandex', uid: '123456') }
    let(:service) { double('Services::FindForOauth') }

    it 'call Services::FindForOauth' do
      expect(Services::FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)

      User.find_for_oauth(auth)
    end
  end
end
