require 'test_helper'

class DataReaderTest < ActiveSupport::TestCase

  def setup
    @filename = "#{Rails.root.join('test','data', 'test1.tab')}"
  end

  test "make object graph" do
    data_reader = DataReader.new
    def data_reader.passthrough(results, company_id); make_object_graph(results, company_id); end

    graph = data_reader.passthrough(results, "1")
    assert_equal(expected_graph, graph)
  end

  test "file to array" do
    data_reader = DataReader.new
    def data_reader.passthrough(filename); file_to_array(filename); end

    array = data_reader.passthrough(@filename)
    assert_equal(expected_array, array)
  end

  test "object graph" do
    uploaded_file = ActionDispatch::Http::UploadedFile.new({:tempfile => File.new(@filename)})
    graph = DataReader.new.object_graph(uploaded_file.tempfile, "1")
    #assert_equal(expected_graph, graph)
  end

private
  def results
    [
      {:purchaser_name=>"p1", :item_description=>"d1", :item_price=>1.0, :purchase_count=>1, :merchant_address=>"1 St", :merchant_name=>"m1"},
      {:purchaser_name=>"p2", :item_description=>"d2", :item_price=>2.0, :purchase_count=>2, :merchant_address=>"2 st", :merchant_name=>"m2"}
    ]
  end

  def expected_graph
    {
      :company=> {:company_id=>"1"},
      :purchasers=>[{:name=>"p1"}, {:name=>"p2"}],
      :items=>[{:description=>"d1", :price=>1.0, :merchant=>"m1"}, {:description=>"d2", :price=>2.0, :merchant=>"m2"}],
      :merchants=>[{:name=>"m1", :address=>"1 St"}, {:name=>"m2", :address=>"2 st"}],
      :orders=>[
        {:company=>{:company_id=>"1"}, :item_description=>"d1", :count=>1, :purchaser=>"p1"},
        {:company=>{:company_id=>"1"}, :item_description=>"d2", :count=>2, :purchaser=>"p2"}
      ]
    }
  end

  def expected_array
    [
      {:purchaser_name_item_description_item_price_purchase_count_merchant_address_merchant_name => "p1  d1  1.0 1   a1  m1"},
      {:purchaser_name_item_description_item_price_purchase_count_merchant_address_merchant_name => "p2  d2  2.0 2   a2  m2"}
    ]
  end
end
