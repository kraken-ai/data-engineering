require 'test_helper'

class PurchaserTest < ActiveSupport::TestCase
  test "name is required" do
    joe = Purchaser.new
    assert_equal(false, joe.valid?)
    assert_not_nil joe.errors.messages[:name]

    joe.name = "joe"
    assert_equal(true, joe.valid?)
  end

  test "creates multiple purchasers from hashes" do
    delete_items(["purchaser"])
    purchasers = [{:name => 'joe'}, {:name => 'jane'}]
    assert_equal(0, Purchaser.all.count)

    Purchaser.create_purchasers(purchasers)
    assert_equal(2, Purchaser.all.count)

    delete_items(["purchaser"])
  end
end
