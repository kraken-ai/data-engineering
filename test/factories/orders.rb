# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    id 1
    item_id 1
    item_count 1
    company_id 1
    purchaser_id 1
  end
end
