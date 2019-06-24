require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :for_user }
  it { should belong_to :by_user }
  it { should belong_to :task }

  it { should validate_presence_of :body }

  describe 'validate uniq' do
    subject { create :review, :with_users }

    it { should validate_uniqueness_of(:by_user_id).scoped_to(:for_user_id, :task_id) }
  end
end
