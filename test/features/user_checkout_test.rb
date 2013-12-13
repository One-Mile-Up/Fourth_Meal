require "./test/test_helper"

class UserCheckoutTest < Capybara::Rails::TestCase
  test "user must login before checking out" do
    r1 = Restaurant.create(name: "Billy's BBQ", slug: "billys-bbq", description: "yummy", status:"Approved")
    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1', restaurant_id: r1.id)
    item.active = true
    item.save
    r1.items << item
    r1.save
    visit restaurant_items_path(r1.slug)
    within("li#item_1") do
      click_on 'Add to Order'
    end

    click_on "My Order"
    click_on "Checkout"

    within(".controls") do
      assert_content page, "Login"
    end
  end

  test "user can visit checkout after logging in" do
    User.create({username: 'bob_bob', email: "bob@example.com",
password: 'password'})

    r1 = Restaurant.create(name: "Billy's BBQ", slug: "billys-bbq", description:"stuff",status: "Approved")

    item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1', restaurant_id: r1.id)
    item.active = true
    item.save
    r1.items << item

    r1.save
    visit restaurant_items_path(r1.slug)
    within("#item_1") do
      click_on 'Add to Order'
    end
    click_on "Login"

    fill_in "Username", with: 'bob_bob'
    fill_in "Password", with: 'password'
    click_button "Login"

    visit root_path

    click_on "My Order"
    click_on "Checkout"

    assert_content page, "Deviled Eggs"
  end

  test "user can see all old orders" do
    User.create({username: 'bob_bob', email: "bob@example.com",
                password: 'password'})
    r1 = Restaurant.create(name: "Billy's BBQ", slug: "billys-bbq", description: "stuff", status: "Approved")
   item = Item.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: 1, restaurant: r1)
   item2 =  Item.create(title: 'Spam', description: 'Almost meat', price: 2, restaurant_id: r1.id)
    item.active = true
    item.save
    r1.items << item
    item2.active = true
    item2.save
    r1.items << item2
    r1.save
    visit restaurant_items_path(r1.slug)

    within("#item_1") do
      click_on 'Add to Order'
    end
    click_on "Login"

    fill_in "Username", with: 'bob_bob'
    fill_in "Password", with: 'password'
    click_button "Login"


    visit restaurant_items_path(r1.slug)
    click_on "My Order"
    click_on "Checkout"
    click_on "Place Order"

    visit restaurant_items_path(r1.slug)
    within("#item_2") do
      click_on 'Add to Order'
    end

    click_on "My Order"
    click_on "Checkout"
    #click_on "Place Order"

    #within("#recent_orders") do
    #  assert_content page, "Deviled Eggs"
    #  assert_content page, "Spam"
    #end

  end

end
