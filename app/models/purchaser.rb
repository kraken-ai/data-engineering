class Purchaser < ActiveRecord::Base
  attr_accessible :name
  has_many :orders
  validates :name, :presence => true

  def self.create_purchasers(purchasers)
    purchasers.each{|purchaser| Purchaser.create(purchaser)}
  end
end
