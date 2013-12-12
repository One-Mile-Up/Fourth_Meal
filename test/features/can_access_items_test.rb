require "./test/test_helper"

class CanAccessItemsTest < Capybara::Rails::TestCase
  attr_reader :restaurant
  
  def setup
    @restaurant = Restaurant.create!(name: "Billy's BBQ", description: "Burger", slug: "billys-bbq", status: "Approved")
  end

  test "can see all items" do
    item = Item.new(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    item.save
    restaurant.items << item
    restaurant.save

    visit restaurant_path(restaurant.slug)

    assert_content page, "Deviled Eggs"
    refute_content page, "Bread"
  end

  test "can see item category" do
    category = Category.create(name: "Plates")
    item = Item.create({title: "Burger", description: "Loafy goodness", price: '1'})
    category.items << item
    restaurant.items << item
    restaurant.categories << category
    restaurant.save

    visit restaurant_path(restaurant.slug)

    assert_content page, "Burger"
    assert_content page, "Plates"
  end


  test "inactive items are not visible" do
    item = Item.create({title: "Burger", description: "Loafy goodness", price: '1', active: false})
    item2 = Item.create({title: "Pita", description: "Loafy badness", price:'1', active: true})
    restaurant.items << item
    restaurant.items << item2

    restaurant.save

    visit restaurant_path(restaurant.slug)

    within("#items") do
      assert_content page, "Loafy badness"
      refute_content page, "Loafy goodness"
    end
  end

  test "can view individual item info" do
    item = Item.create({title: "Burger", description: "Loafy goodness", price: '1'})
    @item2 = Item.create({title: "Pita", description: "Loafy badness", price:'1'})
    restaurant.items << item
    restaurant.save

    visit restaurant_path(restaurant.slug)

    within("#item_1") do
      click_on "#{item.title}"
    end
    assert_content page, "$1.00"
    assert_content page, "Burger"
  end

end
