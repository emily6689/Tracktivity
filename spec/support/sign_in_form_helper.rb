module FormCompletionHelper
  def fill_in_form(user)
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
  end

  def fill_out_form(user)
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
  end

  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within ('form') do
      click_on 'Sign in'
    end
  end
end
