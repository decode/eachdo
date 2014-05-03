# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :house do
    identifier "MyString"
    name "MyString"
    address "MyString"
    house_type "MyString"
    area "9.99"
    floor 1
    floor_type "MyString"
    capacity "MyString"
    bed "MyString"
    direction "MyString"
    status "MyString"
    user nil
  end
end
