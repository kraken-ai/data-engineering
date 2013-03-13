require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "must have an open_id" do
    apple = Company.new
    assert_equal(false, apple.valid?)
    assert_not_nil apple.errors.messages[:open_id]

    apple.open_id = "12345"
    assert_equal(true, apple.valid?)
  end

  test "calculates total sales correctly" do
    apple = Company.create({:open_id => 99999})
    joe = Purchaser.create({:name => 'joe'})
    vail = Merchant.create({:name => 'Vail', :address => '123 first street, Vail, CO'})
    ski_trip = Item.create({:description => '3 for 1 ski trip, $99', :price => 99.00, :merchant_id => vail.id})
    order = Order.create({:item_id => ski_trip.id, :item_count => 1, :company_id => apple.id, :purchaser_id => joe.id})

    assert_equal(99.00, apple.total_sales)

    apple.delete; joe.delete; vail.delete; ski_trip.delete
  end

  test "calculates total sales even if no orders exist" do
    apple = Company.create({:open_id => 99999})
    assert_equal(0.00, apple.total_sales)
    apple.delete
  end
end
