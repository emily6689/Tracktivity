require 'spec_helper'

feature "user can view their productivity statements", %Q{
  As a curious user,
  I want to view a statement containing graphs pertaining to my productivity data,
  So that I can compare my time allocation across time.
} do

# ---Acceptance Criteria---
# *A user must be signed-in to view their statements
# *On the statements page, there are two options: weekly statement, and monthly statement.
# *The viewer must select a date to view the statement.


  scenario "A signed-in user can view their weekly statement" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user)
    activity1 = FactoryGirl.create(:activity, user: user)
    activity2 = FactoryGirl.create(:activity, user: user)
    activity3 = FactoryGirl.create(:activity, user: user)
    activity4 = FactoryGirl.create(:activity, user: user)
    activity5 = FactoryGirl.create(:activity, name: "HiddenActivity", user: user2)
    log = FactoryGirl.create(:log, activity: activity1)
    log1 = FactoryGirl.create(:log, activity: activity2)

    visit root_path
    click_on "Statements"

    expect(current_path).to eql(logs_path)
  end


  scenario "logs can be grouped by week" do
    Seeders::CategoriesSeeder.seed
    date1 = DateTime.new(2014, 4, 7, 8, 20)
    date2 = DateTime.new(2014, 4, 7, 9, 30)
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user)
    activity1 = FactoryGirl.create(:activity, user: user)
    activity2 = FactoryGirl.create(:activity, user: user)
    activity3 = FactoryGirl.create(:activity, user: user2)
    categorization1 = FactoryGirl.create(:categorization, activity_id: activity1.id)
    categorization2 = FactoryGirl.create(:categorization, activity_id: activity1.id, category_id: 2)
    categorization3 = FactoryGirl.create(:categorization, activity_id: activity2.id, category_id: 3)
    log1 = FactoryGirl.create(:log, activity: activity1, time_clocked_in: date1, time_clocked_out: date2)
    log2 = FactoryGirl.create(:log, activity: activity2, time_clocked_in: date1+1, time_clocked_out: date2+2)
    log3 = FactoryGirl.create(:log, activity: activity2, time_clocked_in: date1+3, time_clocked_out: date2+3)
    log4 = FactoryGirl.create(:log, activity: activity2, time_clocked_in: date1+10, time_clocked_out: date2+10)
    log5 = FactoryGirl.create(:log, activity: activity3 , time_clocked_in: date1, time_clocked_out: date2)

    visit root_path
    click_on "Statements"

    select "2014", from: "q[date(1i)]"
    select "April", from: "q[date(2i)]"
    select "8", from: "q[date(3i)]"
    click_on "Search"
  end
end
