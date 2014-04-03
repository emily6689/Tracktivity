require 'spec_helper'



feature 'user signs up', %Q{
  As an unregistered user,
  I want to supply my email, username, and password
  So that I can register for a new account
} do

  # Acceptance Criteria:
  # *If I specify an unregistered email, with a password, and a matching password confirmation, I am able to sign up for a new account.
  # *I have the option to supply my full name, and username.
  # *I am authenticated upon registering

  scenario 'specifies all the valid information' do
    visit root_path

    click_link 'Sign up'
    fill_in 'First Name',
      with: 'Emily'
    fill_in 'Last Name',
      with: 'Williams'
    fill_in 'Email',
      with: 'user@example.com'
    fill_in 'user_password',
      with: 'password'
    fill_in 'user_password_confirmation',
      with: 'password'
    within('form') do
      click_button 'Sign up'
    end

    expect(page).to have_content("Congrats! You're all signed-up.")
    expect(page).to have_content("Sign out")
    expect(current_path).to eql(root_path)
  end


  scenario 'all required information not included' do
    visit root_path
    click_link 'Sign up'
    within('form') do
      click_button 'Sign up'
    end

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign out")
  end

  scenario 'password confirmation does not match confirmation' do
    visit root_path
    click_link 'Sign up'
    fill_in 'user_password',
      with: 'password'
    fill_in 'user_password_confirmation',
      with: 'thisisDifferent'

    within('form') do
      click_button 'Sign up'
    end

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end






feature 'user signs up', %Q{
  As a user
  I want to sign in
  So that I can track my personal activities
} do

  # Acceptance Criteria
  # *If I specify a valid, previously registered email and password I am authenticated and gain access to the system.
  # *If I specify an invalid email and password, I remain unauthenticated
  # *If I am already signed in, I can't sign in again.

  scenario "A registered user enters their correct email and password" do
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

    expect(page).to have_content("Signed in successfully.")
  end


  scenario "A user enters the wrong password" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign in'
    fill_in 'Email',
      with: user.email
    fill_in 'Password',
      with: 'notmypassword'
    within('form') do
      click_button 'Sign in'
    end

    expect(page).to have_content("Invalid email or password.")
  end
end
