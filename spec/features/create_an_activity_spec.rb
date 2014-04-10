require 'spec_helper'

feature 'create activity', %Q{
  1. As a new user,
  I want to create activities to track,
  So they will be included in my daily & monthly productivity statements

  2. As a user creating an activity,
  I want to assign my activity to one or more general categories
  So I can track how my time is generally being spent
} do

  # ---Acceptance Criteria---
  # *There is an option to create a new activity
  # *There is a text box to manually enter your activity’s name
  # *There are check boxes under the text field, to select categories that correspond to the activity.
  # *There is a submit button to send this information to the database.
  # *The user will get an error message if the activity is not assigned to at least one category.
  # *The user will get an error message if the activity does not have a specified name.





  describe "a signed-in user creates an activity to track" do
    before :each do
      Seeders::CategoriesSeeder.seed
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit new_activity_path
    end

    scenario 'user adds a activity with valid attributes' do
      new_activity = FactoryGirl.build(:activity)
      prev_count = Activity.count

      fill_in 'New Activity',
        with: new_activity.name
      check 'Hobbies'
      check 'Relaxation'
      click_on 'Create'

      expect(page).to have_content("You're activity was successfully created. Yay!")
      expect(Activity.last.categories.count).to eql(2)
      expect(Activity.count).to eql(prev_count + 1)
    end


    scenario "user doesn't fill out 'Activity Name'" do
      new_activity = FactoryGirl.build(:activity)
      prev_count = Activity.count

      check 'Hobbies'
      check 'Relaxation'
      click_on 'Create'

      expect(page).to have_content("Please fill out all the required fields.")
      expect(Activity.count).to eql(prev_count)
    end
  end
end
