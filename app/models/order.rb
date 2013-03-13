class Order < ActiveRecord::Base
  attr_accessible :company_id, :item_count, :item_id, :purchaser_id
  belongs_to :company
  belongs_to :purchaser
  belongs_to :item
  validates :company_id, :item_count, :item_id, :purchaser_id, :presence => true

  def self.create_orders(orders, company_id)
    orders.each{|order| Order.create({
      :item_id => Item.find_by_description(order[:item_description]).id,
      :item_count => order[:count].to_i,
      :company_id => company_id,
      :purchaser_id => Purchaser.find_by_name(order[:purchaser]).id
    })}
  end
end
