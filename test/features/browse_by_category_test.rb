require "./test/test_helper"

class BrowseByCategoryTest < Capybara::Rails::TestCase

  test "can browse items by category" do
    cat1 = Category.create({:name => "Plates"})
    cat2 = Category.create({:name => "Desserts"})
    item1 = Item.create({:title => "Bread", :description => "Rye", :price => 5})
    item2 = Item.create({:title => "Cheese", :description => "Swiss", :price => 7})
    item1.categories << cat1
    item2.categories << cat2

    restaurant = Restaurant.create!(:name => "Billy's BBQ", :slug => "billys-bbq", :status => "Approved")
    restaurant.categories << cat1
    restaurant.save
    visit restaurant_path(restaurant.slug)
    select('Plates', :from => 'Categories')
    click_button "Browse by Category"
    within('#items > ul') do
      refute_content page, "Desserts"
    end
  end
end
