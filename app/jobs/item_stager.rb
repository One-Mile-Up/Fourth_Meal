class ItemStager
  @queue = :seed

  def self.perform(restaurant_id, n)
    puts "Starting Item Staging Job"
    @restaurant = Restaurant.find(restaurant_id)
    rid = @restaurant.id

    puts "Creating Item Maker Job for #{@restaurant.name}"
    Resque.enqueue(ItemMaker, self.title(n), self.price,
		   "Yummy Description", rid)
    puts "Finished Item Staging Job"
  end

  def self.title(n)
    @title = "#{@restaurant.name} item #{n}"
    puts @title
    return @title
  end

  def self.price
   @price = (1..25).to_a.sample
    puts "The price is #{@price}"
    return @price
  end

end
