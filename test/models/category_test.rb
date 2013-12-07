require './test/test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "it we can find restaurant categories by slug" do
    r1 = Restaurant.create(name: "Billy's BBQ")
    c1 = Category.create(name: "Beer", restaurant_id: r1.id)

    assert Category.categories_by_slug(r1.slug).include?(c1)
  end
end
