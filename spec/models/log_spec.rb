require 'spec_helper'

describe Log do
  context "validations" do
    it { should validate_presence_of(:activity) }
    it { should validate_presence_of(:time_clocked_in) }
  end

  context "associations" do
    it {should belong_to(:activity) }
  end

  context "clock-out to update log" do
    it "is a completed log when the user clocks out" do
      log = FactoryGirl.create(:log, time_clocked_in: DateTime.now, time_clocked_out: nil)

    end
  end

  context "datetime instance methods" do
    it 'should making calculations based on clock-in and clock-out attributes' do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))
      expect(log.calculate_duration).to eql(130)
    end
  end
end
