require 'spec_helper'

describe Activity do
  context 'validations' do
    before(:each) do
      FactoryGirl.create(:activity)
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id)}
  end

  context 'associations' do
    it { should belong_to :user }
    it { should have_many :categorizations}
    it { should have_many(:categories).through(:categorizations) }
    it { should have_many(:logs) }
  end
end
