class Item < ActiveRecord::Base
  attr_accessible :description, :merchant_id, :price
  belongs_to :merchant
  validates :description, :merchant_id, :price, :presence => true

  def self.create_items(items)
    items.each{|item| Item.create({
      :description => item[:description],
      :price => item[:price].to_f,
      :merchant_id => Merchant.find_by_name(item[:merchant]).id
    })}
  end
end
