require "./test/test_helper"

class CategoryMakerTest < ActiveSupport::TestCase
  test " Category Maker exists" do
    assert CategoryMaker
  end

  test "Category Maker makes" do
    c_count = Category.all.count
    r1 = Restaurant.create!(name: "Monkey Biznas", description: "Its Bananas",
			    slug: "monkey-biznas", status: "Approved")

    CategoryMaker.perform("bananas", r1.id)
    category = r1.categories.last

    assert_equal c_count + 1, Category.all.count
    assert_equal  "bananas", category.name
  end
end
