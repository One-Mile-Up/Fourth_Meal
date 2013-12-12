require "./test/test_helper"

class CanCreateRestaurantsTest < Capybara::Rails::TestCase

  test "can view individual restaurant pages " do
    restaurant1 = Restaurant.create(name: "Billy's BBQ", slug:"billys-bbq", 
                                    description: "yummy", status: "Approved")
    restaurant2 = Restaurant.create(name: "Dive Bar", slug: "dive-bar",
                                    description: "drinks", status: "Approved")

    visit "/billys-bbq"
    assert_content page, "Billy's BBQ"

    visit "/dive-bar"
    assert_content page, "Dive Bar"
  end

  test "restaurant has only its items" do
    restaurant1 = Restaurant.create(name: "Billy's BBQ", slug:"billys-bbq", description: "yummy", status: "Approved")
    restaurant2 = Restaurant.create(name: "Dive Bar", slug: "dive-bar", description: "drinks", status: "Approved")
    item1 = Item.create(title: "Pork Sandwich", description: "Delicious", price: 5, restaurant_id: restaurant1.id)
    item2 = Item.create(title: "PBR", description: "Hiptastic", price: 3, restaurant_id: restaurant2.id)

    visit "/billys-bbq"
    assert_content page, "Pork Sandwich"
    refute_content page, "PBR"

    visit "/dive-bar"
    assert_content page, "PBR"
    refute_content page, "Pork Sandwich"
  end

  test "restaurant can be created on new page" do
   # visit "/restaurants/new"
   # assert_content page, "New Restaurant Form"
    # while on "new" page - user can put in restaurant name
    # url
    # description
  end

  test "as an admin, i can approve pending restaruant request" do
    user = User.create!(username: "admin", email:"admin@example.com", password: "password")
    user.admin = true
    user.save
    visit '/login'
    fill_in "Username", with: "admin"
    fill_in "Password", with:"password"
    click_button "Login"

    restaurant1 = Restaurant.create(name: "Billy's BBQ", slug:"billys-bbq", description: "yummy")

    visit dashboard_path
    within "#edit_restaurant_1" do
      select "Approved", from: "Status"
      click_on "Update Status"
    end

    visit restaurant_path(restaurant1.slug)
    assert_equal current_path, restaurant_path(restaurant1.slug)
  end

end














