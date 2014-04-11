# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Emily'
    last_name 'Williams'
    sequence(:email) { |n| "emily#{n}@williams.com" }
    password 'password'
  end
end
