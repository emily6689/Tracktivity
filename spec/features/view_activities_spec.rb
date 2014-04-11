require 'spec_helper'

feature "View all Activites", %Q{
  As an active user,
  I want activity links on the homepage to bring me to the show pages,
  So I can clock-in there
} do

  # ---Acceptance Criteria---
  # *The user homepage has a list of Activities
  # *These activities serve as links to the activity show pages


  scenario "the homepage lists all users currently tracked activities" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user)
    activity1 = FactoryGirl.create(:activity, user: user)
    activity2 = FactoryGirl.create(:activity, user: user)
    activity3 = FactoryGirl.create(:activity, user: user)
    activity4 = FactoryGirl.create(:activity, user: user)
    activity5 = FactoryGirl.create(:activity, name: "HiddenActivity", user: user2)
    visit root_path
    save_and_open_page
    expect(page).to have_content(activity1.name)
    expect(page).to_not have_content("HiddenActivity")
  end

  scenario "The list of activities serve as links to activity show-pages" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    sign_in_as(user)
    activity1 = FactoryGirl.create(:activity, user: user)
    activity2 = FactoryGirl.create(:activity, user: user)
    activity3 = FactoryGirl.create(:activity, user: user)
    activity4 = FactoryGirl.create(:activity, user: user)
    activity5 = FactoryGirl.create(:activity, name: "HiddenActivity", user: user2)
    visit root_path

    click_link activity1.name

    expect(current_path).to eql(activity_path(activity1))
  end






end


