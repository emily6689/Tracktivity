require 'spec_helper'

describe Log do
  context "validations" do
    it { should validate_presence_of(:activity_id) }
    it { should validate_presence_of(:time_clocked_in) }
    it { should validate_presence_of(:time_clocked_out) }
  end

  context "associations" do
    it {should belong_to(:activity) }
  end

end
