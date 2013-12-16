require "./test/test_helper"

class ItemStagerTest < ActiveSupport::TestCase
  test "Item Stager exists" do
    assert ItemStager
  end

  test "Item Stager makes title" do
    restaurant = Restaurant.create(name: "Jorge's Tacos", description: "Cow Tongue",
				   slug: "jorges-tacos", status: "Approved")
    ItemStager.perform(restaurant.id)
    assert ItemStager.title.include?(restaurant.name)
    assert ItemStager.title.include?("item")
    assert_equal ItemStager.description.class, String
    assert_equal ItemStager.image_url.class, String
    assert_equal ItemStager.price.class, Fixnum
  end
end
