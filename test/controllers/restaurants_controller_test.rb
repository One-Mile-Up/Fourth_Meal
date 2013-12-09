require "./test/test_helper"

class RestaurantsControllerTest < ActionController::TestCase

  test "restaurant has show page" do
    restaurant1 = Restaurant.create(name: "Billy's BBQ")

    get :show, restaurant_slug: restaurant1.slug
    assert_response 200
  end

  test "restaurant has a new page" do
    get :new
    assert_response 200
  end

end
