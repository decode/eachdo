# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :price do
    house nil
    day "9.99"
    week "9.99"
    month "9.99"
    weekend "9.99"
    weekend_type "MyString"
  end
end
