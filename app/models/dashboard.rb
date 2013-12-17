class Dashboard

  def restaurants
    Restaurant.order("status DESC")
  end

  def items
    Item.all
  end

  def categories
    Category.all
  end

  def orders
    Order.all
  end

  def users
    User.all
  end
end
