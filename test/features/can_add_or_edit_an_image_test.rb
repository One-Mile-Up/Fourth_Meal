require "./test/test_helper"

class CanAddOrEditAnImageTest < Capybara::Rails::TestCase

  test "can add an image to an item" do
    user1 = User.new({username: 'admin', password: 'password', email: 'admin@example.com'})
    user1.admin = true
    user1.save

    item = Item.new(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')
    item.save

    restaurant = Restaurant.create!(name: "Billy's BBQ", description: "Burger", slug: "billys-bbq", status: "Approved")
    restaurant.items << item
    restaurant.save
    restaurant.users << user1

    visit root_path
    click_on "Login"

    fill_in "Username", with: 'admin'
    fill_in "Password", with: 'password'
    click_button "Login"

    visit edit_item_path(restaurant.slug, item.id)
    attach_file("item_image", "./app/assets/images/deviled_eggs.jpg")
    click_button "Update"
    visit restaurant_items_path(restaurant.slug)
    assert page.body.include? "deviled_eggs.jpg"
  end

end
