require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to :author }
  it { should belong_to :task }

  describe '#edit_time_not_left?' do
    let(:comment) { create :comment, :with_task }
    let(:comment2) { create :comment, :with_task }

    it 'true' do
      expect(comment).to be_edit_time_not_left
    end

    it 'false' do
      comment2.updated_at = comment2.updated_at.utc - 6.minutes
      expect(comment2).to_not be_edit_time_not_left
    end
  end
end
