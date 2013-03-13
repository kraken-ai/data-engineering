class Merchant < ActiveRecord::Base
  attr_accessible :address, :name
  has_many :items
  validates :address, :name, :presence => true

  def self.create_merchants(merchants)
    merchants.each{|merchant| Merchant.create(merchant)}
  end
end
