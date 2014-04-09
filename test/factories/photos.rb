# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    album nil
    title "MyString"
    image "MyString"
    description "MyText"
  end
end
