class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :categories
  validates_uniqueness_of :name

  
end
