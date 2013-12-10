require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "it can reference user" do
    user = User.create!(username: "Jeff", email: "jeff@example.com", password: "password")
    restaurant = Restaurant.create!(name: "Place", slug: "place", description: "place")
    role = Role.create!(user_id: user.id, restaurant_id: restaurant.id)
    assert_equal restaurant, role.restaurant
    assert_equal user, role.user
  end
end
