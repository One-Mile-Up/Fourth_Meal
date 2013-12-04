require 'test_helper'

class DashboardTest < ActiveSupport::TestCase
  test "Dashboard exists" do
    assert Dashboard
  end

  test "Dashboard returns all items" do
   dashboard = Dashboard.new
   assert_equal Item.all, dashboard.items
  end

  test "Dashboard returns all categories" do
    dashboard = Dashboard.new
    assert_equal Category.all, dashboard.categories
  end

  test "Dashboard returns all orders" do
    dashboard = Dashboard.new
    assert_equal Order.all, dashboard.orders
  end

  test "Dashboard returns all users" do
    dashboard = Dashboard.new
    assert_equal User.all, dashboard.users
  end
end
