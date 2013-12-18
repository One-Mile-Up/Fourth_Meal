require "./test/test_helper"

class ItemMakerTest < ActiveSupport::TestCase
  test "Item Maker Exists" do
    assert ItemMaker
  end

  test "Item Maker makes item" do
    r1 = Restaurant.create(name: "Tony's", description:"Joes", slug: "tonys",
			   status: "Approved")
    ItemMaker.perform("salad", 9, "green", r1.id)
    item = r1.items.last

    assert_equal "salad", item.title
    assert_equal  9, item.price
    assert_equal  "green", item.description
    assert r1.items.include? item
  end
end

