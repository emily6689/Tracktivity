require 'spec_helper'

describe Log do
  context "validations" do
    it { should validate_presence_of(:activity) }
    it { should validate_presence_of(:time_clocked_in) }
  end

  context "associations" do
    it { should belong_to(:activity) }
    it { should have_many(:categories).through(:activity) }
  end


  context "datetime instance methods" do
    it 'should calculate duration based on clock-in and clock-out attributes' do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))

      expect(log.calculate_duration).to eql(130)
    end

    it "user can organize logs by day or week" do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))
      log3 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,22,8,19,0), time_clocked_out: DateTime.new(2014,2,22,9,30,0))

      expect(Log.sort_by_day(2014,2,4)).to match_array([log1, log2])
      expect(Log.sort_by_day(2014,2,3)).to match_array([log])
      expect(Log.sort_by_week(DateTime.new(2014,2,3))).to match_array([log, log1, log2])
    end

    it "user can organize logs by week" do
      log = FactoryGirl.create(:log)
      log1 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,4,30,0), time_clocked_out: DateTime.new(2014,2,4,6,40,0))
      log2 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,4,7,30,0), time_clocked_out: DateTime.new(2014,2,4,8,40,0))
      log3 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,2,22,8,19,0), time_clocked_out: DateTime.new(2014,2,22,9,30,0))
      log4 = FactoryGirl.create(:log, time_clocked_in: DateTime.new(2014,3,22,8,19,0), time_clocked_out: DateTime.new(2014,3,22,9,30,0))

      expect(Log.sort_by_month(2014, 2)).to match_array([log, log1, log2, log3])
      expect(Log.sort_by_month(2014, 3)).to match_array([log4])
    end
  end
end
