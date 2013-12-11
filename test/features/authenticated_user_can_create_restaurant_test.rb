require "./test/test_helper"

class AuthenticatedUserCanCreateRestaurantTest < Capybara::Rails::TestCase

  test "authenticated user can create restaurant" do
    login_user
    visit new_restaurants
    Restaurant.create

  end

end
