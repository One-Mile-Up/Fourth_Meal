require "./test/test_helper"

class AuthenticatedUserCanCreateRestaurantTest < Capybara::Rails::TestCase

  def login_user
    user = User.new
    user.username = 'user'
    user.password = 'password'
    user.email = 'user@example.com'
    user.save

    visit root_path

    click_on "Login"

    fill_in "Username", with: 'user'
    fill_in "Password", with: 'password'
    click_button "Login"
  end

  test "authenticated user can create restaurant" do
    login_user
    visit new_restaurant_path
    Restaurant.create
    fill_in "Name", with: "Terry's Tavern"
    fill_in "Description", with: "Burger-n-fries"
    fill_in "Slug", with: "terrys-tavern"
    click_button "submit"

    assert_content "Terry's Tavern is pending approval."
  end

end
