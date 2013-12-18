module OrdersHelper

  def make_restaurant_orders(restaurant_orders)
    restaurant_orders.each_with_object([]) do |order, array|
     array << order
    end
  end

end
