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

end
