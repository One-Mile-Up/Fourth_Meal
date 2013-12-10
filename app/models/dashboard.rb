class Dashboard

  def restaurants
    Restaurant.all
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
