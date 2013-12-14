require "./test/test_helper"

class CanViewCategoriesTest < Capybara::Rails::TestCase

  test "can see all items by category" do
    r1 = Restaurant.create!(name:"Billy's BBQ", slug:"billys-bbq", description:"yes", status:"Approved")
    category = Category.create(name: "brunch")
    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    category.items << item
    r1.items << item
    r1.categories << category

    visit restaurant_items_path(r1.slug)
    assert_content page, "Deviled Eggs"
    assert_content page, "brunch"
  end

  test "can click tag to see all items with that tag" do
    category = Category.create(name: "brunch")
    category2 = Category.create(name: "plates")
    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    item2 = Item.create(title: 'Ham Sandwich', description: 'Pretty basic', price: '2')

    r1 = Restaurant.create!(name:"Billy's BBQ", slug:"billys-bbq", description:"yes", status:"Approved")
    category.items << item
    category2.items << item2
    r1.categories << category
    r1.categories << category2
    r1.items << item
    r1.items << item2
    r1.save!
    visit root_path
    click_on("Billy's BBQ")

    within("#item_1") do
    click_on "brunch"
    end

    refute_content page, "Ham Sandwich"

  end

end
