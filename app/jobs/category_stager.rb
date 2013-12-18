class CategoryStager
  @queue = :seed

  def self.perform(restaurant_id, n)
    puts "Starting Category Staging Job"
    @restaurant = Restaurant.find(restaurant_id)
    category = self.make_category_data(n)
    puts "Creating Category Maker Job"
    Resque.enqueue(CategoryMaker, category[:name], category[:restaurant_id])
    puts "Finished Category Staging Job"
  end

  def self.make_category_data(n)
    {
      name: "#{@restaurant.name} category #{n}",
      restaurant_id: @restaurant.id
    }
  end
end
