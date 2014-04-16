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

    visit root_path
    click_on "Statements"

    expect(current_path).to eql(activity_logs_path)
  end

end
