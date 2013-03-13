require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "must have description, merchant_id, price" do
    required_attributes = %w[description merchant_id price]

    item = Item.new
    assert_equal(false, item.valid?)
    required_attributes.each {|attribute| assert_not_nil item.errors.messages[attribute.to_sym]}

    item.description = "foo"
    item.merchant_id = 1
    item.price = 1.00
    assert_equal(true, item.valid?)
  end

  test "creates multiple items from hashes" do
    delete_items(["item", "merchant"])
    assert_equal(0, Item.all.count)

    apple = Merchant.create({:name => 'apple', :address => '123 first street'})
    items = [{:description => "foo", :price => 99.95, :merchant => apple.name}, {:description => "bar", :price => 22.23, :merchant => apple.name}]
    Item.create_items(items)
    assert_equal(2, Item.all.count)

    delete_items(["item", "merchant"])
  end

end
