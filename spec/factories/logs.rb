# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    activity
    time_clocked_in DateTime.new(2014,2,3,4,30,0)
    time_clocked_out DateTime.new(2014,2,3,6,40,0)
  end
end
