require "./test/test_helper"

class CanCreateRestaurantsTest < Capybara::Rails::TestCase
  attr_reader :owner

  def setup
    @owner = User.create!(username: "owner", email:"owner@example.com", password: "password")
    restaurant1 = Restaurant.create(name: "Billy's BBQ", slug:"billys-bbq", description: "yummy")
  end

  test "can add item to their restaruant" do
  end
end

