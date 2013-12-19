class CategoryMaker
  @queue = :seed

  def self.perform(name, restaurant_id)
    puts "Starting Category Maker Job"
    new_category = Category.find_or_create_by!(name: name, restaurant_id: restaurant_id)
    puts "Finished Category Maker Job #{new_category.name}"
  end
end
