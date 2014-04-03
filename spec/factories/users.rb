# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Emily'
    last_name 'Williams'
    email 'emily@williams.com'
    password 'password'
  end
end
