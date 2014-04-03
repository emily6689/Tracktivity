require 'spec_helper'

describe Activity do
  context 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:user_id)}
  end

  context 'associations' do
    it {should belong_to :user}
  end

end
