# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :information do
    user nil
    login_count 1
    rank "MyString"
    credit "9.99"
  end
end
