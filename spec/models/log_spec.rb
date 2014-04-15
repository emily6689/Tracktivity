require 'spec_helper'

describe Log do
  context "validations" do
    it { should validate_presence_of(:activity) }
    it { should validate_presence_of(:time_clocked_in) }
  end

  context "associations" do
    it { should belong_to(:activity) }
  end


  context "datetime instance methods" do
    before(:each) do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))
    end

    it 'should calculate duration based on clock-in and clock-out attributes' do
      expect(log.calculate_duration).to eql(130)
    end

    it "you should be able to organize logs by date" do
      expect(Log.sort_by_day(2/4/2014)).
    end

  end

  context "can be invoked by date" do

  end
end
