class Category < ActiveRecord::Base
  has_many :item_categories
  has_many :items, through: :item_categories
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  belongs_to :restaurant

  def self.categories_by_slug(slug)
    restaurant = Restaurant.find_by(slug: slug)
    self.where(restaurant_id: restaurant.id)
  end

end
