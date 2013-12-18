class ItemStager
  @queue = :seed

  def self.perform(restaurant_id, n)
    puts "Starting Item Staging Job"
    @restaurant = Restaurant.find(restaurant_id)
    rid = @restaurant.id
    puts "Creating Item Maker Job for #{@restaurant.name}"

    @title = self.title(n)
    puts @title

    @price =  self.price
    puts "The price is #{@price}"

    Resque.enqueue(ItemMaker, @title, @price,
      self.description, rid)
    puts "Finished Item Staging Job"
  end

  def self.title(n)
    "#{@restaurant.name} item #{n}"
  end

  def self.price
    (1..25).to_a.sample
  end

  def self.description
    letters = ("A".."z").to_a
    description = ""

    140.times do
      description += letters.sample
    end

    puts "description is #{description}"
    return description
  end

end
