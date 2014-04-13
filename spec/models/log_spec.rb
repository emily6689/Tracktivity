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

  context "datetime instance methods" do
    it 'should making calculations based on clock-in and clock-out attributes' do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))
      binding.pry
      expect(log.individual_time_spent).to eql(130)
    end
  end
end
