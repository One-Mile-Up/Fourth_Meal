require "./test/test_helper"

class RestaurantMakerTest < ActiveSupport::TestCase
  test "Restaurant Maker Exists" do
    assert  RestaurantMaker
  end

  test "Restaurant Maker makes restaurant" do
    name = "Kevin's Seafood"
    description = "Fishy"
    slug = "kevins-seafood"
    status = "Approved"
    count = Restaurant.all.count

    RestaurantMaker.perform(name, description, slug, status)

    restaurant = Restaurant.last
    assert_equal Restaurant.all.count, count + 1
    assert_equal "Kevin's Seafood", restaurant.name
    assert_equal "Fishy", restaurant.description
    assert_equal "kevins-seafood", restaurant.slug
    assert_equal "Approved", restaurant.status
  end
end
