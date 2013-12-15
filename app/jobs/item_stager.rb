class ItemStager
  @queue = :seed

  def self.perform(restaurant_id)
    puts "Starting Item Staging Job"
    @restaurant = Restaurant.find(restaurant_id)
    rid = @restaurant.id
    puts  "restaurant_id is #{rid}"
    puts "Creating Item Maker Job"
    Resque.enqueue(ItemMaker, self.title, self.price, 
      self.description, self.image_url, rid)
    puts "Finished Item Staging Job"
  end

  def self.title
    "#{@restaurant.name} item #{[(1..999).to_a.sample]}"
  end

  def self.price
    price = (1..25).to_a.sample
    puts "price is #{price}"
    return price
  end

  def self.image_url
    image_url = self.image_urls.sample
    puts "image url is #{image_url}"
    return image_url
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

  def self.image_urls
    ["https://platable.s3.amazonaws.com/items/images/000/000/001/small/deviled_eggs.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/002/small/mac_and_cheese.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/003/small/spoon_bread1.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/004/small/tomato_soup.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/005/small/green_beans.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/006/small/arugula_salad.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/007/small/cubano_sandwich.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/008/small/monte_cristo.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/009/small/classic_burger.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/010/small/veggie_burger.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/011/small/chicken_fried_chicken.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/012/small/seared_ribeye.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/013/small/tacos.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/014/small/pork.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/015/small/grapefruit.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/016/small/coffee_cake.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/017/small/hoecakes.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/018/small/french_toast.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/019/small/denver_omelette.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/020/small/trifle.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/021/small/s'mores.jpg",
"https://platable.s3.amazonaws.com/items/images/000/000/022/small/coco_cake.jpg"]
end

end