require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "must have address, name" do
    required_attributes = %w[address name]

    merchant = Merchant.new
    assert_equal(false, merchant.valid?)
    required_attributes.each {|attribute| assert_not_nil merchant.errors.messages[attribute.to_sym]}

    merchant.address = "foo"
    merchant.name = "bar"
    assert_equal(true, merchant.valid?)
  end

  test "creates multiple merchants from hashes" do
    delete_items(["merchant"])
    merchants = [{:name => 'apple', :address => '123 first street'}, {:name => 'ibm', :address => '234 second street'}]
    assert_equal(0, Merchant.all.count)

    Merchant.create_merchants(merchants)
    assert_equal(2, Merchant.all.count)

    delete_items(["merchant"])
  end
end
