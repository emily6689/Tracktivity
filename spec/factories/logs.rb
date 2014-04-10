# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    activity_id 1
    time_clocked_in "2014-04-10 14:01:49"
    time_clocked_out "2014-04-10 14:01:49"
  end
end
