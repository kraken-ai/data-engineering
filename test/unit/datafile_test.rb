require 'test_helper'

class DatafileTest < ActiveSupport::TestCase

  test "datafile must have a filename to be valid" do
    datafile = Datafile.new
    assert_equal(false, datafile.valid?)
    assert_not_nil datafile.errors.messages[:filename]

    datafile.filename = "foo"
    assert_equal(true, datafile.valid?)
  end

  test "constructor sets filename" do
    datafile = Datafile.new("foo.txt")
    assert_equal(true, datafile.valid?)
    assert_equal("foo.txt", datafile.filename)
  end

end
