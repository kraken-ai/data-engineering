# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    id 1
    description "MyString"
    price 1.5
    merchant_id 1
  end
end
