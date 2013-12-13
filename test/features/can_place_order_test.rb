require './test/test_helper'
require 'pry'
class CanPlaceOrderTest < Capybara::Rails::TestCase

  def login_user
    @user = User.new
    @user.username = 'user'
    @user.password = 'password'
    @user.email = 'user@example.com'
    @user.save

    visit root_path

    click_on "Login"

    fill_in "Username", with: 'user'
    fill_in "Password", with: 'password'
    click_button "Login"
  end


  test "can add an item to the current order" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ", slug: "billys-bbq", status: "Approved")
    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1', restaurant: r1)

    r1.items << item

    login_user

    visit restaurant_items_path(r1.slug)
    within("#item_1") do
      click_on "Add to Order"
    end

    assert_content page, "Deviled Eggs added to cart!"
  end

  test "cannot set the quantity to a negative number" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ", slug: "billys-bbq", status: "Approved")
    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1', restaurant_id: r1.id)
    order = Order.create
    order.items << item

    r1.items << item

    login_user

    visit order_path(order)
    fill_in 'order_item_quantity', with: '-5'
    click_on 'Adjust Quantity'

    assert_content page, 'There was an error.'
    assert_equal "1", find_field('order_item_quantity').value
  end


  test "can add multiple items to order without logging in" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ", slug: "billys-bbq", status: "Approved")
    r2 = Restaurant.find_or_create_by( name: "Dive Bar", slug: "dive-bar", status: "Approved")

    item1 = Item.find_or_create_by(title: 'Deviled Eggs', description: '12 lucious eggs', price: '1', restaurant_id: r1.id)
    item2 = Item.find_or_create_by(title: 'Hard Boiled Eggs', description: '12 hard eggs', price: '1', restaurant_id: r2.id)

    r1.items << item1
    r2.items << item2

    visit restaurant_items_path(r1.slug)
    within("#item_1") do
      click_on "Add to Order"
    end

    visit restaurant_items_path(r2.slug)
    within("#item_2") do
      click_on "Add to Order"
    end

    visit order_path(Order.first)
    within("#item_1") do
      assert_content page, "Deviled Eggs"
    end
    within("#item_2") do
      assert_content page, "Hard Boiled Eggs"
    end
  end

  test " items added to cart are seperated by restaurant" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ", slug: "billys-bbq", status: "Approved")
    r2 = Restaurant.find_or_create_by( name: "Dive Bar", slug: "dive-bar", status: "Approved")

    item1 = Item.find_or_create_by(title: 'Deviled Eggs', description: '12 lucious eggs', price: '1', restaurant_id: r1.id)
    item2 = Item.find_or_create_by(title: 'Hard Boiled Eggs', description: '12 hard eggs', price: '1', restaurant_id: r2.id)

    r1.items << item1
    r2.items << item2

    visit root_path
    visit restaurant_items_path(r1.slug)
    within("#item_#{item1.id}") do
      click_on "Add to Order"
    end

    visit restaurant_items_path(r2.slug)
    within("#item_#{item2.id}") do
      click_on "Add to Order"
    end

    visit order_path(Order.first)
    within("#restaurant_#{r1.id}") do
      assert_content page, "Deviled Eggs"
    end

    within("#restaurant_#{r2.id}") do
      assert_content page, "Hard Boiled Eggs"
    end

  end

  test "can add multiple instances of same item to order" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ", slug: "billys-bbq", status: "Approved")

    item1 = Item.find_or_create_by(title: 'Deviled Eggs', description: '12 lucious eggs', price: '1', restaurant_id: r1.id)

    r1.items << item1

    visit restaurant_items_path(r1.slug)
    within("#item_1") do
      click_on "Add to Order"
    end

    within("#item_1") do
      click_on "Add to Order"
    end

    visit order_path(Order.first)
    within("#item_1") do
      assert_equal "2", find_field('order_item_quantity').value
    end
  end

  test "user can adjust items in cart" do
    r1 = Restaurant.find_or_create_by( name: "Billy's BBQ")
    item = Item.find_or_create_by(title: 'Deviled Eggs', description: '12 lucious eggs', price: '1', restaurant_id: r1.id)
    order = Order.create
    order.items << item
    visit order_path(order)

    within("#item_1") do
      fill_in "order_item_quantity", with: 10
      click_on "Adjust Quantity"
    end

    within("#item_1") do
      assert_equal "10", find_field('order_item_quantity').value
    end
  end


end
