require 'spec_helper'

feature 'create activity', %Q{
  As a new user,
  I want to create activities to track,
  So they will be included in my daily & monthly productivity statements
} do

  # ---Acceptance Criteria---
  # *There is an option to create a new activity
  # *There is a text box to manually enter your activity’s name

  before :each do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign in'
    fill_in 'Email',
      with: user.email
    fill_in 'Password',
      with: user.password
    within('form') do
      click_button 'Sign in'
    end
  end



  scenario 'user adds a movie with valid attributes' do
    new_activity = FactoryGirl.build(:activity)
    prev_count = Activity.count

    visit new_activity_path

    fill_in 'New Activity',
      with: new_activity.name
    click_on 'Create'
    save_and_open_page
    expect(page).to have_content("You're activity was successfully created. Yay!")
  end



end
