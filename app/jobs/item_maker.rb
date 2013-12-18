require 'open-uri'
class ItemMaker
  @queue = :seed

  def self.perform(title, price, description, restaurant_id)
    puts "Starting Item Maker Job"
    new_item = Item.find_or_create_by!(title: title, description: description,
      price: price, restaurant_id: restaurant_id)

    puts "Finished Item Maker Job #{new_item.title} with price: #{new_item.price}, description: #{new_item.description} for restaurant #{restaurant_id}"
  end

end
