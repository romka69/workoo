require 'rails_helper'

RSpec.describe Bid, type: :model do
  it { should belong_to :user }
  it { should belong_to :task }

  describe '#set_approve' do
    let(:bid) { create :bid }

    it 'approved' do
      bid.set_approve

      expect(bid.approve).to eq true
    end
  end
end
