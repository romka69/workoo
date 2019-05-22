require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_many(:users).dependent(:nullify) }

  describe '.find_role' do
    let!(:role) { create :role }

    it 'found' do
      expect(Role.find_role("customer")).to eq role
    end

    it 'not found' do
      expect(Role.find_role("no role")).to_not eq role
    end
  end
end
