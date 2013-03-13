class Company < ActiveRecord::Base
  attr_accessible :open_id
  has_many :orders
  validates_presence_of :open_id

  def total_sales
    sales = 0.0
    self.orders.includes(:item).each {|order| sales += order.item_count * order.item.price}
    sales
  end
end
