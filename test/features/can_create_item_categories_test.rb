require "./test/test_helper"

class CanCreateItemCategoriesTest < Capybara::Rails::TestCase

  def login_user
    user = User.new
    user.username = 'user'
    user.password = 'password'
    user.email = 'user@example.com'
    user.admin = true
    user.save

    visit root_path

    click_on "Login"

    fill_in "Username", with: 'user'
    fill_in "Password", with: 'password'
    click_button "Login"
  end

  test "restaurant has only its categories" do
    login_user
    restaurant1 = Restaurant.create(name: "Billy's BBQ")
    restaurant2 = Restaurant.create(name: "Dive Bar")
    category1 = Category.create(name: "Pork", restaurant_id: restaurant1.id)
    category2 = Category.create(name: "Beer", restaurant_id: restaurant2.id)

    visit "/billys-bbq/categories"
    assert_content page, "Pork"
    refute_content page, "Beer"

    visit "/dive-bar/categories"
    assert_content page, "Beer"
    refute_content page, "Pork"
   end

end
