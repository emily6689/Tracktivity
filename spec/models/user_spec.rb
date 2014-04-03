require 'spec_helper'

describe User do
  it {should validate_presence_of(:first_name)}
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:email)}
  it {should have_valid(:email).when('user@example.com', 'iloverails@ruby.com')}
  it {should_not have_valid(:email).when(nil, '', 'user@.co')}

  it 'has a matching password confirmation for password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'ilovepasswords'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end


end

