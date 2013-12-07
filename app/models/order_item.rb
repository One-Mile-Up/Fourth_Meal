class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates_numericality_of :quantity, greater_than: 0, only_integer: true

  def restaurant
    item.restaurant
  end

  def increase_quantity
      @quantity ||= 0
      @quantity += 1
      save
  end
end
