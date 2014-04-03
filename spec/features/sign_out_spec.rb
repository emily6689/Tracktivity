require 'spec_helper'

feature 'user_signs_out' do
  scenario 'user successfully signs out' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within('form') do
      click_on 'Sign in'
    end
    click_link 'Sign out'

    expect(page).to have_content("Signed out successfully.")
  end
end
