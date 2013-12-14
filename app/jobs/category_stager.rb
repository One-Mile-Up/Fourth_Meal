class CategoryStager
  @queue = :seed

  def self.perform(restaurant_id)
    puts "Starting Category Staging Job"
    @restaurant = Restaurant.find(restaurant_id)
    category = self.make_category_data
    puts "Creating Category Maker Job"
    Resque.enqueue(CategoryMaker, category[:name], category[:restaurant_id])
    puts "Finished Category Staging Job"
  end

  def self.make_category_data
    {
      name: "#{@restaurant.name} category #{(1..999).to_a.sample}",
      restaurant_id: @restaurant.id
    }
  end
end 