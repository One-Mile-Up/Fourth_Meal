require "./test/test_helper"

class CanCreateRestaurantsTest < Capybara::Rails::TestCase

  test "can view individual restaurant pages " do
    restaurant1 = Restaurant.create(name: "Billy's BBQ")
    restaurant2 = Restaurant.create(name: "Dive Bar")
    visit "/billys-bbq"
    assert_content page, "Billy's BBQ"

    visit "/dive-bar"
    assert_content page, "Dive Bar"
  end

  test "restaurant has only its items" do
    restaurant1 = Restaurant.create(name: "Billy's BBQ")
    restaurant2 = Restaurant.create(name: "Dive Bar")
    item1 = Item.create(title: "Pork Sandwich", description: "Delicious", price: 5, restaurant_id: restaurant1.id)
    item2 = Item.create(title: "PBR", description: "Hiptastic", price: 3, restaurant_id: restaurant2.id)

    visit "/billys-bbq"
    assert_content page, "Pork Sandwich"
    refute_content page, "PBR"

    visit "/dive-bar"
    assert_content page, "PBR"
    refute_content page, "Pork Sandwich"
   end

end
