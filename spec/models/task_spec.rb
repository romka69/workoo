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
end
