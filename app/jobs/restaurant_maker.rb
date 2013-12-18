class RestaurantMaker
  @queue = :seed

  def self.perform(name, description, slug, status,num_of_items =20, num_of_catgories = 3)
    puts "Starting Restaurant Job"
    @restaurant = Restaurant.find_or_create_by!(name: name.to_s,
      description: description.to_s, slug: slug.to_s)
    @restaurant.status = status ||"Approved"
    @restaurant.save

    id = @restaurant.id

    num_of_items.times do |n|
      puts "Creating Item Staging job #{n} for #{@restaurant.name}"
      Resque.enqueue(ItemStager, id, n)
    end

    num_of_catgories.times do |n|
      puts "Creating Category Staging job #{n} for #{@restaurant.name}"
      Resque.enqueue(CategoryStager, id, n)
    end
    puts "Restaurant Job Complete"
  end

end
