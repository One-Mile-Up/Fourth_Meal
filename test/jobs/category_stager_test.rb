require "./test/test_helper"

class CategoryStagerTest < ActiveSupport::TestCase
  test "Category Stager extsts" do
    assert CategoryStager
  end

  test "Category Stager creates data" do
    skip
    restaurant = Restaurant.create!(name:"Fried Stuff", description:"Heart Attack",
				   slug:"fried-stuff", status: "Approved")
    CategoryStager.perform(restaurant.id)

    category = restaurant.categories.last

    puts "restaurant #{restaurant.name} has categories of #{restaurant.categories.pluck(:name)}"
    assert_equal category.name.include?("category")
  end
end
