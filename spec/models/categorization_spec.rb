require 'spec_helper'

describe Categorization do
  context 'validations' do
    it { should validate_presence_of(:activity_id) }
    it { should validate_presence_of(:category_id)}
  end

  context 'associations' do
    it { should belong_to(:activity) }
    it { should belong_to(:category) }
  end
end
