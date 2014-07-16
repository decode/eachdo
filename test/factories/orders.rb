# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    house nil
    user nil
    from "2014-07-16"
    to "2014-07-16"
    price "9.99"
    deposit "9.99"
    payment "9.99"
    name "MyString"
    phone "MyString"
    is_oneself false
  end
end
