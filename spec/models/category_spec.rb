require 'spec_helper'

describe Category do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many :categorizations}
    it { should have_many(:activities).through(:categorizations) }
    it { should have_many(:logs).through(:activities)}
  end
end
