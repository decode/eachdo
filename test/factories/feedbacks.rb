# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    house nil
    order nil
    title "MyString"
    comment "MyString"
    rating "9.99"
    judgement "MyString"
  end
end
