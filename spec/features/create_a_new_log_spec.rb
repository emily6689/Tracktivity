require 'spec_helper'

feature "user can create a log by clocking in and out", %Q{
  As an active user,
  I want to be able to select an activity to clock into,
  So that I can track the time I'm spending on this activity
} do

  # ---Acceptance Criteria---
  # *A user can go to the activity show page to clock-in
  # *Once clocked in, there is the option to clock-out on the same page
  # *A user cannot clock-into an activity, where they still haven't clocked out


  scenario "a signed-in user can clock-in" do
    prev_count  =Log.count
    user        =FactoryGirl.create(:user)
    activity1   =FactoryGirl.create(:activity, user: user)
    activity2   =FactoryGirl.create(:activity, user: user)
    sign_in_as(user)
    visit activities_path

    click_on activity1.name
    expect(current_path).to eql(activity_path(activity1))

    click_on "Clock In"
    expect(Log.last.activity).to eql(activity1)
    expect(Log.count).to eql(prev_count + 1)
  end

  scenario "a user can clock-out of the log once clocked-in" do
    user        = FactoryGirl.create(:user)
    activity    = FactoryGirl.create(:activity, user: user)
    log         = FactoryGirl.create(:log, activity: activity, time_clocked_in: (DateTime.now - 30.minutes), time_clocked_out: nil)
    prev_count  = Log.count
    sign_in_as(user)

    visit activity_path(activity)
    click_on "Clock Out"
    log.reload

    expect(Log.count).to eql(prev_count)
    expect(log.time_clocked_out).to_not eql(nil)
    expect(log.duration).to eql(30)
    expect(Log.last).to eql(log)
  end

  scenario "a clocked-in user cannot clock-in again until they are clocked-out" do
    user      = FactoryGirl.create(:user)
    activity1 = FactoryGirl.create(:activity, user: user)
    activity2 = FactoryGirl.create(:activity, user: user)
    log1      = FactoryGirl.create(:log, activity: activity1)
    log2      = FactoryGirl.create(:log, activity: activity2)
    sign_in_as(user)
    prev_log_count = Log.count

    visit activities_path
    click_on activity1.name

    expect(page).to_not have_content("Clock Out")

    click_on "Clock In"

    expect(page).to have_content("Clock Out")
    expect(Log.count).to eql(prev_log_count + 1)
  end
end
