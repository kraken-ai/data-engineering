require 'csv'

class DataReader

  def object_graph(tempfile, company_id)
    results = file_to_array(tempfile)
    graph = make_object_graph(results, company_id)
    graph
  end

private
  def file_to_array(filename = nil)
    items = []

    CSV.foreach(filename, :headers => true, :header_converters => :symbol, :converters => :all, :col_sep => "\t") do |row|
      item = {}
      row.headers.each{|header| item[header] = row[header]}
      items << item
    end

    items
  end

  def make_object_graph(results, company_id)
    company = {:company_id => company_id}
    purchasers, items, merchants, orders = [], [], [], []

    results.each do |row|
      purchasers << {:name => row[:purchaser_name]}
      items << {:description => row[:item_description], :price => row[:item_price], :merchant => row[:merchant_name]}
      merchants << {:name => row[:merchant_name], :address => row[:merchant_address]}
      orders << {:company => company, :item_description => row[:item_description], :count => row[:purchase_count], :purchaser => row[:purchaser_name]}
    end

    merchants.uniq!; purchasers.uniq!; items.uniq!

    {:company => company, :purchasers => purchasers, :items => items, :merchants => merchants, :orders => orders}
  end

end