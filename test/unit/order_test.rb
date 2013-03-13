require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "must have company_id, item_count, item_id, purchaser_id" do
    required_attributes = %w[company_id item_count item_id purchaser_id]

    order = Order.new
    assert_equal(false, order.valid?)
    required_attributes.each {|attribute| assert_not_nil order.errors.messages[attribute.to_sym]}

    order.company_id = 1
    order.item_count = 1
    order.item_id = 1
    order.purchaser_id = 1
    assert_equal(true, order.valid?)
  end

  test "creates multiple items from hashes" do
    delete_items(["order", "merchant", "item", "purchaser", "company"])
    assert_equal(0, Order.all.count)

    ski_city = Company.create({:open_id => "12345"})
    apple = Merchant.create({:name => 'apple', :address => '123 first street'})
    item = Item.create({:description => "foo", :price => 99.95, :merchant_id => apple.id})
    purchaser = Purchaser.create({:name => 'joe'})
    order1 = {:item_description => item.description, :item_count => 1, :company_id => ski_city.id, :purchaser => purchaser.name}
    order2 = {:item_description => item.description, :item_count => 2, :company_id => ski_city.id, :purchaser => purchaser.name}
    Order.create_orders([order1, order2], apple.id)
    assert_equal(2, Order.all.count)

    delete_items(["order", "merchant", "item", "purchaser", "company"])
  end
end
